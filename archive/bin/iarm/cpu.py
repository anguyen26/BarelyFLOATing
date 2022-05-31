import inspect
import random


class RegisterCpu(object):
    """
    A register based CPU
    """
    def __init__(self, bit_width, max_registers, memory_width=8, memory_size=1024, generate_random=False, postpone_execution=True):
        """
        Initialize the CPU and get all instructions and "rules"

        Instructions are operations that the CPU can perform and are defined as bing all capital methods
        Rules are methods that instructions use verify that the arguments are usable by the instruction.
        Rules are defined as starting with 'rule_' and are used by passing the rule name with the arguments as a list.

        :param bit_width: What is the size of the registers
        :param max_registers: How many registers are there (one indexed)
        :param memory_size: What is the size of memory
        :param generate_random: If a register or memory address is undefined, should a random value be generated for it?
        :param postpone_execution: Should instructions be executed immediately or just store the program until a value is asked for (lazy execution)
        :return:
        """
        super().__init__()
        self._bit_width = bit_width
        self._max_registers = max_registers - 1  # Code was made around this being zero indexed
        self._memory_width = memory_width
        self._memory_size = memory_size
        self._generate_random = generate_random
        self._postpone_execution = postpone_execution

        self.register = RandomValueDict(self._bit_width, self._generate_random)  # Holder for the register values
        self.memory = RandomValueDict(self._memory_width, self._generate_random)  # Holder for memory
        self.program = []  # Hold the current program, used for jumps
        self.labels = {}  # A label to program location lookup
        self.ops = {}  # What operations are defined
        self._rules = {}  # Holder for parameter rules

        # Get all instructions and rules
        for obj in inspect.getmembers(self, predicate=inspect.ismethod):
            # Is returned in the form of (method name, method)
            name = obj[0]
            method = obj[1]

            # Instructions are defined by being all uppercase
            if str.isupper(name):
                self.ops[name] = method
            # Rules are defined with starting with 'rule_'
            elif str.startswith(name, 'rule_'):
                self._rules[name[len('rule_'):]] = method

    def check_arguments(self, **kwargs):
        """
        Determine if the parameters meet the specifications
        kwargs contains lists grouped by their parameter
        rules are defined by methods starting with 'rule_'
        :param kwargs:
        :return:
        """
        for key in kwargs:
            if key in self._rules:
                for val in kwargs[key]:
                    self._rules[key](val)
            else:
                raise LookupError("Rule for {} does not exist. Make sure the rule starts with 'rule_'".format(key))

    def evaluate(self, code):
        # must be implemented on inheriting classes
        raise NotImplementedError("The class cant determine how to run the code")

    @property
    def generate_random(self):
        return self._generate_random

    @generate_random.setter
    def generate_random(self, value):
        self._generate_random = value
        self.memory._generate_random = value
        self.register._generate_random = value

    @property
    def postpone_execution(self):
        return self._postpone_execution

    @postpone_execution.setter
    def postpone_execution(self, value):
        self._postpone_execution = value



class RandomValueDict(dict):
    """
    Class for registers and memory
    Used to simulate randomness by generating random values if a value has not been set yet.
    """
    def __init__(self, bit_width, generate_random=False, *args, **kwargs):
        """
        :param bit_width: What is the width of the memory being accessed. Used to determine the max value
        :param generate_random: Should a random number be generated, or zero returned if the value is not set
        """
        self._bit_width = bit_width
        self._generate_random = generate_random
        self._linked_keys = {}  # Used to mirror two entries in the dict
        super().__init__(*args, **kwargs)

    def __getitem__(self, item):
        """
        Get the register value of item

        If item has not been defined yet,
        then either 0 or a random number will be returned
        depending on the flag _generate_random
        :param item: The register to get the value
        :return: The integer value of the register
        """
        if self._generate_random:
            if super().get(item, None) is None:
                val = random.randint(0, 2**self._bit_width - 1)
                self[item] = val
        return super().get(item, 0)

    def link(self, key1, key2):
        """
        Make these two keys have the same value
        :param key1:
        :param key2:
        :return:
        """
        # TODO make this have more than one key linked
        # TODO Maybe make the value a set?
        self._linked_keys[key1] = key2
        self._linked_keys[key2] = key1

    def __setitem__(self, key, value):
        """
        If two values are linked, set the value of both
        :param key:
        :param value:
        :return:
        """
        # TODO make this transitive
        # TODO if 'a' and 'b' are linked, and 'b' and 'c' are linked, updaing 'c' does not update 'a'
        if key in self._linked_keys.keys():
            key2 = self._linked_keys[key]
            super().__setitem__(key2, value & 2**self._bit_width - 1)
        super().__setitem__(key, value & 2**self._bit_width - 1)
