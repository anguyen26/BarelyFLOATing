from ipykernel.kernelbase import Kernel
from iarm.arm import Arm
import re
import warnings
import iarm.exceptions


class ArmKernel(Kernel):
    implementation = 'IArm'
    implementation_version = '0.1.0'
    language = 'ARM'
    language_version = iarm.__version__
    language_info = {
        'name': 'ARM Coretex M0+ Thumb Assembly',
        'mimetype': 'text/x-asm',
        'file_extension': '.s'
    }
    banner = "Interpreted ARM"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.interpreter = Arm(1024)  # 1K memory
        self.magics = {
            'run': self.magic_run,
            'register': self.magic_register,
            'reg': self.magic_register,
            'memory': self.magic_memory,
            'mem': self.magic_memory,
            'signed': self.magic_signed_rep,
            'unsigned': self.magic_unsigned_rep,
            'hex': self.magic_hex_rep,
            'help': self.magic_help,
            'generate_random': self.magic_generate_random,
            'postpone_execution': self.magic_postpone_execution
                       }

        self.number_representation = ''
        self.magic_unsigned_rep('')  # Default to unsigned representation

    def convert_representation(self, i):
        """
        Return the proper representation for the given integer
        """
        if self.number_representation == 'unsigned':
            return i
        elif self.number_representation == 'signed':
            if i & (1 << self.interpreter._bit_width - 1):
                return -((~i + 1) & (2**self.interpreter._bit_width - 1))
            else:
                return i
        elif self.number_representation == 'hex':
            return hex(i)

    def magic_generate_random(self, line):
        """
        Set the generate random flag, unset registers and memory will return a random value.

        Usage:
        Call the magic by itself or with `true` to have registers and memory return a random value
        if they are unset and read from, much like how real hardware would work.
        Defaults to False, or to not generate random values

        `%generate_random`
        or
        `%generate_random true`
        or
        `%generate_random false`
        """
        line = line.strip().lower()
        if not line or line == 'true':
            self.interpreter.generate_random = True
        elif line == 'false':
            self.interpreter.generate_random = False
        else:
            stream_content = {'name': 'stderr', 'text': "unknwon value '{}'".format(line)}
            self.send_response(self.iopub_socket, 'stream', stream_content)
            return {'status': 'error',
                    'execution_count': self.execution_count,
                    'ename': ValueError.__name__,
                    'evalue': "unknwon value '{}'".format(line),
                    'traceback': '???'}

    def magic_postpone_execution(self, line):
        """
        Postpone execution of instructions until explicitly run

        Usage:
        Call this magic with `true` or nothing to postpone execution,
        or call with `false` to execute each instruction when evaluated.
        This defaults to True.

        Note that each cell is executed only executed after all lines in
        the cell have been evaluated properly.

        `%postpone_execution`
        or
        `%postpone_execution true`
        or
        `%postpone_execution false`
        """
        line = line.strip().lower()
        if not line or line == 'true':
            self.interpreter.postpone_execution = True
        elif line == 'false':
            self.interpreter.postpone_execution = False
        else:
            stream_content = {'name': 'stderr', 'text': "unknwon value '{}'".format(line)}
            self.send_response(self.iopub_socket, 'stream', stream_content)
            return {'status': 'error',
                    'execution_count': self.execution_count,
                    'ename': ValueError.__name__,
                    'evalue': "unknwon value '{}'".format(line),
                    'traceback': '???'}

    def magic_signed_rep(self, line):
        """
        Convert all values to it's signed representation

        Usage:
        Just call this magic

        `%signed`
        """
        self.number_representation = 'signed'

    def magic_unsigned_rep(self, line):
        """
        All outputted values will be displayed with their unsigned representation

        Usage:
        Just call this magic

        `%unsigned`
        """
        self.number_representation = 'unsigned'

    def magic_hex_rep(self, line):
        """
        All outputed values will be displayed with their hexadecimal representation

        Usage:
        Just call this magic

        `%hex`
        """
        self.number_representation = 'hex'

    def magic_register(self, line):
        """
        Print out the current value of a register

        Usage:
        Pass in the register, or a list of registers separated by spaces
        A list of registeres can be entered by separating them by a hyphen

        `%reg R1`
        or
        `%reg R0 R5 R6`
        or
        `%reg R8-R12`
        """
        message = ""
        for reg in [i.strip() for i in line.replace(',', '').split()]:
            if '-' in reg:
                # We have a range (Rn-Rk)
                r1, r2 = reg.split('-')
                # TODO do we want to allow just numbers?
                n1 = re.search(self.interpreter.REGISTER_REGEX, r1).groups()[0]
                n2 = re.search(self.interpreter.REGISTER_REGEX, r2).groups()[0]
                n1 = self.interpreter.convert_to_integer(n1)
                n2 = self.interpreter.convert_to_integer(n2)
                for i in range(n1, n2+1):
                    val = self.interpreter.register[r1[0] + str(i)]
                    val = self.convert_representation(val)
                    message += "{}: {}\n".format(r1[0] + str(i), val)
            else:
                val = self.interpreter.register[reg]
                val = self.convert_representation(val)
                message += "{}: {}\n".format(reg, val)
        stream_content = {'name': 'stdout', 'text': message}
        self.send_response(self.iopub_socket, 'stream', stream_content)

    def magic_memory(self, line):
        """
        Print out the current value of memory

        Usage:
        Pass in the byte of memory to read, separated by spaced
        A list of memory contents can be entered by separating them by a hyphen

        `%mem 4 5`
        or
        `%mem 8-12`
        """
        # TODO add support for directives
        message = ""
        for address in [i.strip() for i in line.replace(',', '').split()]:
            if '-' in address:
                # We have a range (n-k)
                m1, m2 = address.split('-')
                n1 = re.search(self.interpreter.IMMEDIATE_NUMBER, m1).groups()[0]
                n2 = re.search(self.interpreter.IMMEDIATE_NUMBER, m2).groups()[0]
                n1 = self.interpreter.convert_to_integer(n1)
                n2 = self.interpreter.convert_to_integer(n2)
                for i in range(n1, n2 + 1):
                    val = self.interpreter.memory[i]
                    val = self.convert_representation(val)
                    message += "{}: {}\n".format(str(i), val)
            else:
                # TODO fix what is the key for memory (currently it's an int, but registers are strings, should it be the same?)
                val = self.interpreter.memory[self.interpreter.convert_to_integer(address)]
                val = self.convert_representation(val)
                message += "{}: {}\n".format(address, val)
        stream_content = {'name': 'stdout', 'text': message}
        self.send_response(self.iopub_socket, 'stream', stream_content)

    def magic_run(self, line):
        """
        Run the current program

        Usage:
        Call with a numbe rto run that many steps,
        or call with no arguments to run to the end of the current program

        `%run`
        or
        `%run 1`
        """
        i = float('inf')
        if line.strip():
            i = int(line)

        try:
            with warnings.catch_warnings(record=True) as w:
                self.interpreter.run(i)
                for warning_message in w:
                    # TODO should this be stdout or stderr
                    stream_content = {'name': 'stdout', 'text': 'Warning: ' + str(warning_message.message) + '\n'}
                    self.send_response(self.iopub_socket, 'stream', stream_content)
        except iarm.exceptions.EndOfProgram as e:
            f_name = self.interpreter.program[self.interpreter.register['PC'] - 1].__name__
            f_name = f_name[:f_name.find('_')]
            message = "Error in {}: ".format(f_name)
            stream_content = {'name': 'stdout', 'text': message + str(e) + '\n'}
            self.send_response(self.iopub_socket, 'stream', stream_content)
        except Exception as e:
            for err in e.args:
                stream_content = {'name': 'stderr', 'text': str(err)}
                self.send_response(self.iopub_socket, 'stream', stream_content)
            return {'status': 'error',
                    'execution_count': self.execution_count,
                    'ename': type(e).__name__,
                    'evalue': str(e),
                    'traceback': '???'}

    def magic_help(self, line):
        """
        Print out the help for magics

        Usage:
        Call help with no arguments to list all magics,
        or call it with a magic to print out it's help info.

        `%help`
        or
        `%help run
        """
        line = line.strip()
        if not line:
            for magic in self.magics:
                stream_content = {'name': 'stdout', 'text': "%{}\n".format(magic)}
                self.send_response(self.iopub_socket, 'stream', stream_content)
        elif line in self.magics:
            # its a magic
            stream_content = {'name': 'stdout', 'text': "{}\n{}".format(line, self.magics[line].__doc__)}
            self.send_response(self.iopub_socket, 'stream', stream_content)
        elif line in self.interpreter.ops:
            # it's an instruction
            stream_content = {'name': 'stdout', 'text': "{}\n{}".format(line, self.interpreter.ops[line].__doc__)}
            self.send_response(self.iopub_socket, 'stream', stream_content)
        else:
            stream_content = {'name': 'stderr', 'text': "'{}' not a known magic or instruction".format(line)}
            self.send_response(self.iopub_socket, 'stream', stream_content)

    # TODO add tab completion
    # TODO add completeness (can be used to return the prompt back to the user in case of an error)

    def run_magic(self, line):
        # TODO allow magics at end of code block
        # TODO allow more than one magic per block
        if line.startswith('%'):
            loc = line.find(' ')
            params = ""
            if loc > 0:
                params = line[loc + 1:]
                op = line[1:loc]
            else:
                op = line[1:]
            return self.magics[op](params)

    def run_code(self, code):
        if not code:
            return
        try:
            with warnings.catch_warnings(record=True) as w:
                self.interpreter.evaluate(code)
                for warning_message in w:
                    # TODO should this be stdout or stderr
                    stream_content = {'name': 'stdout', 'text': 'Warning: ' + str(warning_message.message) + '\n'}
                    self.send_response(self.iopub_socket, 'stream', stream_content)
        except Exception as e:
            for err in e.args:
                stream_content = {'name': 'stderr', 'text': "{}\n{}".format(type(e).__name__, str(err))}
                self.send_response(self.iopub_socket, 'stream', stream_content)
            return {'status': 'error',
                    'execution_count': self.execution_count,
                    'ename': type(e).__name__,
                    'evalue': str(e),
                    'traceback': '???'}

    def do_execute(self, code, silent, store_history=True,
                   user_expressions=None, allow_stdin=False):

        instructions = ""
        for line in code.split('\n'):
            if line.startswith('%'):
                # TODO run current code, run magic, then continue
                ret = self.run_code(instructions)
                if ret:
                    return ret
                instructions = ""
                ret = self.run_magic(line)
                if ret:
                    return ret
            else:
                instructions += line + '\n'
        ret = self.run_code(instructions)
        if ret:
            return ret

        return {'status': 'ok',
                'execution_count': self.execution_count,
                'payload': [],
                'user_expressions': {}
                }

if __name__ == '__main__':
    from ipykernel.kernelapp import IPKernelApp
    IPKernelApp.launch_instance(kernel_class=ArmKernel)
