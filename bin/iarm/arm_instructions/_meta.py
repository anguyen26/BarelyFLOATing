import re
import iarm.exceptions
import iarm.cpu
import warnings


class _Meta(iarm.cpu.RegisterCpu):
    """
    Give helper functions to the instructions
    """
    REGISTER_NUMBER = r'(\d+)'
    REGISTER_REGEX = r'^R{}$'.format(REGISTER_NUMBER)
    IMMEDIATE_NUMBER = r'(0[xX][0-9a-zA-Z]+|2_\d+|\d+)'
    IMMEDIATE_REGEX = r'^#{}$'.format(IMMEDIATE_NUMBER)
    ONE_PARAMETER = r'\s*([^\s,]*)(,\s*[^\s,]*)*\s*'
    TWO_PARAMETER_COMMA_SEPARATED = r'\s*([^\s,]*),\s*([^\s,]*)(,\s*[^\s,]*)*\s*'
    THREE_PARAMETER_COMMA_SEPARATED = r'\s*([^\s,]*),\s*([^\s,]*),\s*([^\s,]*)(,\s*[^\s,]*)*\s*'
    WHITESPACE = r' \t\r\f\v'  # No newline

    def parse_lines(self, code):
        """
        Return a list of the parsed code

        For each line, return a three-tuple containing:
        1. The label
        2. The instruction
        3. Any arguments or parameters

        An element in the tuple may be None or '' if it did not find anything
        :param code: The code to parse
        :return: A list of tuples in the form of (label, instruction, parameters)
        """
        remove_comments = re.compile(r'^([^;\n]*);?.*$', re.MULTILINE)
        code = '\n'.join(remove_comments.findall(code))  # TODO can probably do this better
        # TODO labels with spaces between pipes is allowed `|label with space| INST OPER`
        parser = re.compile(r'^(\w*)?[ \t\r\f\v]*(\S*)[ \t\r\f\v]*(.*)$', re.MULTILINE)
        return parser.findall(code)

    def is_register(self, R):
        """
        Is R a register.

        Finds out by doing a regex match for R and a number
        Does not check if the register is within range
        :param R: The parameter to check
        :return: True if the parameter is a register
        """
        return re.search(self.REGISTER_REGEX, R) is not None

    def is_immediate(self, I):
        """
        Is I an immediate

        Only checks if a '#' symbol is preceding a number
        Does not check bounds
        :param I: The parameter to check
        :return: True if the parameter is an immediate
        """
        return re.search(self.IMMEDIATE_REGEX, I) is not None

    def check_parameter(self, arg):
        """
        Is the parameter defined, or not None

        Raises an exception if
        1. The parameter is undefined
        :param arg: The parameter to check
        :return: None
        """
        if arg is None or arg == '':
            raise iarm.exceptions.RuleError("Parameter is None, did you miss a comma?")

    def check_register(self, arg):
        """
        Is the parameter a register in the form of 'R<d>',
        and if so is it within the bounds of registers defined

        Raises an exception if
        1. The parameter is not in the form of 'R<d>'
        2. <d> is outside the range of registers defined in the init value
            registers or _max_registers
        :param arg: The parameter to check
        :return: The number of the register
        """
        self.check_parameter(arg)
        match = re.search(self.REGISTER_REGEX, arg)
        if match is None:
            raise iarm.exceptions.RuleError("Parameter {} is not a register".format(arg))
        try:
            r_num = int(match.groups()[0])
        except ValueError:
            r_num = int(match.groups()[0], 16)
        if r_num > self._max_registers:
            raise iarm.exceptions.RuleError(
                "Register {} is greater than defined registers of {}".format(arg, self._max_registers))

        return r_num

    def check_immediate(self, arg):
        """
        Is the parameter an immediate in the form of '#<d>',

        Raises an exception if
        1. The parameter is not in the form of '#<d>'
        :param arg: The parameter to check
        :return: The value of the immediate
        """
        self.check_parameter(arg)
        match = re.search(self.IMMEDIATE_REGEX, arg)
        if match is None:
            raise iarm.exceptions.RuleError("Parameter {} is not an immediate".format(arg))
        return self.convert_to_integer(match.groups()[0])

    def convert_to_integer(self, str):
        if str.startswith('0x') or str.startswith('0X'):
            return int(str, 16)
        elif str.startswith('2_'):
            return int(str[2:], 2)
        else:
            return int(str)

    def check_immediate_unsigned_value(self, arg, bit):
        """
        Is the immediate within the unsigned value of 2**bit - 1

        Raises an exception if
        1. The immediate value is > 2**bit - 1
        :param arg: The parameter to check
        :param bit: The number of bits to use in 2**bit
        :return: The value of the immediate
        """
        i_num = self.check_immediate(arg)
        if (i_num > (2 ** bit - 1)) or (i_num < 0):
            raise iarm.exceptions.RuleError("Immediate {} is not an unsigned {} bit value".format(arg, bit))
        return i_num

    def check_immediate_value(self, arg, _max, _min=0):
        """
        Is the immediate within the range of [_min, _max]

        Raises an exception if
        1. The immediate value is < _min or > _max
        :param arg: The parameter to check
        :param _max: The maximum value
        :param _min: The minimum value, optional, default is zero
        :return: The immediate value
        """
        i_num = self.check_immediate(arg)
        if (i_num > _max) or (i_num < _min):
            raise iarm.exceptions.RuleError("Immediate {} is not within the range of [{}, {}]".format(arg, _min, _max))
        return i_num

    def check_multiple_of(self, value, multiple_of):
        if (value % multiple_of) != 0:
            raise iarm.exceptions.RuleError("Immediate {} is not a multiple of {}".format(value, multiple_of))

    # Rules
    def rule_low_registers(self, arg):
        """Low registers are R0 - R7"""
        r_num = self.check_register(arg)
        if r_num > 7:
            raise iarm.exceptions.RuleError(
                "Register {} is not a low register".format(arg))

    def rule_high_registers(self, arg):
        """High registers are R8 - R12"""
        r_num = self.check_register(arg)
        if (r_num < 8) or (r_num > 12):
            raise iarm.exceptions.RuleError(
                "Register {} is not a high register".format(arg))

    def rule_general_purpose_registers(self, arg):
        """General purpose registers are R0-R12"""
        r_num = self.check_register(arg)
        if r_num > 12:
            raise iarm.exceptions.RuleError(
                "Register {} is not a general purpose register".format(arg))

    def rule_any_registers(self, arg):
        """Any register R0 - R15"""
        self.check_register(arg)

    def rule_imm3(self, arg):
        """
        Is the argument an immediate that is in the range of [0,7]
        :param arg: An immediate in the form of '#d'
        :return: None
        """
        self.check_immediate_unsigned_value(arg, 3)

    def rule_imm5(self, arg):
        """
        Is the argument an immediate that is in the range of [0,31]
        :param arg: An immediate in the form of '#d'
        :return: None
        """
        self.check_immediate_unsigned_value(arg, 5)

    def rule_imm5_counting(self, arg):
        self.check_immediate_value(arg, 2 ** 5, 1)

    def rule_imm6_2(self, arg):
        i_num = self.check_immediate_unsigned_value(arg, 6)
        self.check_multiple_of(i_num, 2)

    def rule_imm7_4(self, arg):
        i_num = self.check_immediate_unsigned_value(arg, 7)
        self.check_multiple_of(i_num, 4)

    def rule_imm8(self, arg):
        self.check_immediate_unsigned_value(arg, 8)

    def rule_immS8_2(self, arg):
        i_num = self.check_immediate_value(arg, 2 ** 8 - 1, -(2 ** 8))
        self.check_multiple_of(i_num, 2)

    def rule_imm9_4(self, arg):
        i_num = self.check_immediate_unsigned_value(arg, 9)
        self.check_multiple_of(i_num, 4)

    def rule_imm10_4(self, arg):
        i_num = self.check_immediate_unsigned_value(arg, 10)
        self.check_multiple_of(i_num, 4)

    def rule_immS25_4(self, arg):
        i_num = self.check_immediate_value(arg, 2 ** 25, -2 ** 25)
        self.check_multiple_of(i_num, 4)

    def get_parameters(self, regex_exp, parameters):
        """
        Given a regex expression and the string with the paramers,
        either return a regex match object or raise an exception if the regex
        did not find a match
        :param regex_exp:
        :param parameters:
        :return:
        """
        # TODO find a better way to do the equate replacement
        for rep in self.equates:
            parameters = parameters.replace(rep, str(self.equates[rep]))
        match = re.match(regex_exp, parameters)
        if not match:
            raise iarm.exceptions.ParsingError("Parameters are None, did you miss a comma?")

        return match.groups()

    def get_one_parameter(self, regex_exp, parameters):
        """
        Get three parameters from a given regex expression

        Raise an exception if more than three were found
        :param regex_exp:
        :param parameters:
        :return:
        """
        Rx, other = self.get_parameters(regex_exp, parameters)
        if other is not None and other.strip():
            raise iarm.exceptions.ParsingError("Extra arguments found: {}".format(other))
        return Rx

    def get_two_parameters(self, regex_exp, parameters):
        """
        Get two parameters from a given regex expression

        Raise an exception if more than two were found
        :param regex_exp:
        :param parameters:
        :return:
        """
        Rx, Ry, other = self.get_parameters(regex_exp, parameters)
        if other is not None and other.strip():
            raise iarm.exceptions.ParsingError("Extra arguments found: {}".format(other))
        if Rx and Ry:
            return Rx, Ry
        elif not Rx:
            raise iarm.exceptions.ParsingError("Missing first positional argument")
        else:
            raise iarm.exceptions.ParsingError("Missing second positional argument")

    def get_three_parameters(self, regex_exp, parameters):
        """
        Get three parameters from a given regex expression

        Raise an exception if more than three were found
        :param regex_exp:
        :param parameters:
        :return:
        """
        Rx, Ry, Rz, other = self.get_parameters(regex_exp, parameters)
        if other is not None and other.strip():
            raise iarm.exceptions.ParsingError("Extra arguments found: {}".format(other))
        return Rx, Ry, Rz

    def set_APSR_flag_to_value(self, flag, value):
        """
        Set or clear flag in ASPR
        :param flag: The flag to set
        :param value: If value evaulates to true, it is set, cleared otherwise
        :return:
        """
        if flag == 'N':
            bit = 31
        elif flag == 'Z':
            bit = 30
        elif flag == 'C':
            bit = 29
        elif flag == 'V':
            bit = 28
        else:
            raise AttributeError("Flag {} does not exist in the APSR".format(flag))

        if value:
            self.register['APSR'] |= (1 << bit)
        else:
            self.register['APSR'] -= (1 << bit) if (self.register['APSR'] & (1 << bit)) else 0

    def rule_special_registers(self, arg):
        """Raises an exception if the register is not a special register"""
        # TODO is PSR supposed to be here?
        special_registers = "PSR APSR IPSR EPSR PRIMASK FAULTMASK BASEPRI CONTROL"
        if arg not in special_registers.split():
            raise iarm.exceptions.RuleError("{} is not a special register; Must be [{}]".format(arg, special_registers))

    def rule_LR_or_general_purpose_registers(self, arg):
        if (arg != 'LR') and (arg != 'R14'):
            self.check_arguments(general_purpose_registers=(arg,))

    def set_N_flag(self, result):
        if result & (1 << self._bit_width - 1):
            self.set_APSR_flag_to_value('N', 1)
        else:
            self.set_APSR_flag_to_value('N', 0)

    def set_Z_flag(self, result):
        if result == 0:
            self.set_APSR_flag_to_value('Z', 1)
        else:
            self.set_APSR_flag_to_value('Z', 0)

    def set_C_flag(self, oper_1, oper_2, result, type):
        """
        Set C flag
        C flag is set if the unsigned number overflows
        This condition is obtained if:
        1. In addition, the result is smaller than either of the operands
        2. In subtraction, if the second operand is larger than the first

        This should not be used for shifting as each shift will need to set
        the C flag differently
        """
        # TODO is this correct?
        if type == 'add':
            if result < oper_1:
                self.set_APSR_flag_to_value('C', 1)
            else:
                self.set_APSR_flag_to_value('C', 0)
        elif type == 'sub':
            if oper_1 < oper_2:
                # If there was a borrow, then set to zero
                self.set_APSR_flag_to_value('C', 0)
            else:
                self.set_APSR_flag_to_value('C', 1)
        elif type == 'shift-left':
            if (oper_2 > 0) and (oper_2 < (self._bit_width - 1)):
                self.set_APSR_flag_to_value('C', oper_1 & (1 << (self._bit_width - oper_2)))
            else:
                self.set_APSR_flag_to_value('C', 0)
        else:
            raise iarm.exceptions.BrainFart("_type is not 'add' or 'sub'")

    def set_V_flag(self, oper_1, oper_2, result, _type):
        # Set the V flag
        if _type == 'add':
            pass
        elif _type == 'sub':
            oper_2 = (~oper_2 & (2**self._bit_width - 1)) + 1
        else:
            raise iarm.exceptions.BrainFart("_type is not 'add' or 'sub'")

        if (oper_1 + oper_2) >= (1 << 31):
            if ((oper_1 & (1 << self._bit_width - 1)) and (oper_2 & (1 << self._bit_width - 1)) and not (result & (1 << self._bit_width - 1))) or \
               (not (oper_1 & (1 << self._bit_width - 1)) and not (oper_2 & (1 << self._bit_width - 1)) and (result & (1 << self._bit_width - 1))):
                self.set_APSR_flag_to_value('V', 1)
            else:
                self.set_APSR_flag_to_value('V', 0)
        else:
            self.set_APSR_flag_to_value('V', 0)

    def set_NZ_flags(self, result):
        self.set_N_flag(result)
        self.set_Z_flag(result)

    def set_NZCV_flags(self, oper_1, oper_2, result, _type):
        self.set_NZ_flags(result)
        self.set_C_flag(oper_1, oper_2, result, _type)
        self.set_V_flag(oper_1, oper_2, result, _type)

    def rule_R0_thru_R14(self, arg):
        if arg not in ('LR', 'R14', 'SP', 'R13'):
            self.check_arguments(general_purpose_registers=(arg,))

    def is_N_set(self):
        return True if (self.register['APSR'] & (1 << 31)) else False

    def is_Z_set(self):
        return True if (self.register['APSR'] & (1 << 30)) else False

    def is_C_set(self):
        return True if (self.register['APSR'] & (1 << 29)) else False

    def is_V_set(self):
        return True if (self.register['APSR'] & (1 << 28)) else False

    def rule_label_exists(self, arg):
        if (arg not in self.labels) and (arg != '.'):
            warnings.warn("Label {} does not exist yet".format(arg), iarm.exceptions.LabelDoesNotExist)

    def match_first_two_parameters(self, Ra, Rb):
        if Ra != Rb:
            raise iarm.exceptions.RuleError("First parameter {} does not match second parameter {}".format(Ra, Rb))
