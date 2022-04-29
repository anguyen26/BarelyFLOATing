import iarm.exceptions
from ._meta import _Meta


class Memory(_Meta):
    THREE_PARAMETER_WITH_BRACKETS = r'\s*([^\s,]*),\s*\[([^\s,]*),\s*([^\s,]*)\](,\s*[^\s,]*)*\s*'

    def ADR(self, params):
        """
        ADR Ra, [PC, #imm10_4]
        ADR Ra, label

        Load the address of label or the PC offset into Ra
        Ra must be a low register
        """
        # TODO may need to rethink how I do PC, may need to be byte alligned
        # TODO This is wrong as each address is a word, not a byte. The filled value with its location (Do we want that, or the value at that location [Decompiled instruction])
        try:
            Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_WITH_BRACKETS, params)
        except iarm.exceptions.ParsingError:
            Ra, label = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

            # TODO the address must be within 1020 bytes of current PC
            self.check_arguments(low_registers=(Ra,), label_exists=(label,))

            def ADR_func():
                self.register[Ra] = self.labels[label]  # TODO is this correct?

            return ADR_func

        self.check_arguments(low_registers=(Ra,), imm10_4=(Rc,))
        if Rb != 'PC':
            raise iarm.exceptions.IarmError("Second position argument is not PC: {}".format(Rb))

        def ADR_func():
            self.register[Ra] = self.register[Rb] + self.convert_to_integer(Rc[1:])

        return ADR_func

    def LDM(self, params):
        """
        LDM Ra!, {RLoList}

        Load multiple with Ra not in RLoList
        """
        # TODO what registers can be stored?
        # TODO add the load multiple with Ra in RLoList
        Ra, RLoList = self.get_two_parameters(r'\s*([^\s,]*)!,\s*{(.*)}(.*)', params).split(',')
        RLoList = RLoList.split(',')
        RLoList = [i.strip() for i in RLoList]

        self.check_arguments(low_registers=[Ra] + RLoList)

        def LDM_func():
            for i in range(len(RLoList)):
                for j in range(4):
                    self.memory[self.register[Ra] + 4*i + j] = ((self.register[RLoList[i]] >> (8 * j)) & 0xFF)
                    self.register[RLoList[i]] = self.memory[self.register[Ra] + (4 * i) + j]
            self.register[Ra] += 4*len(RLoList)

        return LDM_func

    def LDR(self, params):
        """
        LDR Ra, [PC, #imm10_4]
        LDR Ra, label
        LDR Ra, =equate
        LDR Ra, [Rb, Rc]
        LDR Ra, [Rb, #imm7_4]
        LDR Ra, [SP, #imm10_4]

        Load a word from memory into Ra
        Ra, Rb, and Rc must be low registers
        """
        # TODO definition for PC is Ra <- M[PC + Imm10_4], Imm10_4 = PC - label, need to figure this one out
        try:
            Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_WITH_BRACKETS, params)
        except iarm.exceptions.ParsingError:
            Ra, label = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

            if label.startswith('='):
                # This is a pseudoinstructions
                label = label[1:]
                # TODO add check that label is a 32 bit number
                # TODO This does not work on instruction loading. This interpreter follows a harvard like architecture,
                # TODO while ARMv6-M (Cortex-M0+) is a Von Neumann architeture. Instructions will not be decompiled
                self.check_arguments(low_registers=(Ra,))
                if label in self.labels:
                    label = self.labels[label]
                elif label in self.equates:
                    label = self.equates[label]
                else:
                    try:
                        label = int(self.convert_to_integer(label))
                    except ValueError:
                        raise iarm.exceptions.IarmError("'{}' is not a label, equate, or parsable integer".format(label))

                # TODO this crashes if SPACE has not been hit yet.
                # TODO find a way to defer this if it is not yet available
                if int(label) % 4 != 0:
                    raise iarm.exceptions.IarmError("Memory access not word aligned; Immediate: {}".format(int(label)))
            elif label.startswith('[') and label.endswith(']'):
                # TODO improve this
                Rb = label[1:-1]
                if Rb == 'SP' or Rb == 'R13':
                    self.check_arguments(low_registers=(Ra,))
                else:
                    self.check_arguments(low_registers=(Ra, label))

                def LDR_func():
                    if self.memory[Rb] % 4 != 0:
                        raise iarm.exceptions.HardFault(
                            "Memory access not word aligned; Register: {}  Immediate: {}".format(self.register[Rb],
                                                                                                 self.convert_to_integer(
                                                                                                     Rc[1:])))
                    self.register[Ra] = 0
                    for i in range(4):
                        self.register[Ra] |= (self.memory[self.register[Rb] + i] << (8 * i))
                return LDR_func
            else:
                self.check_arguments(low_registers=(Ra,), label_exists=(label,))
                try:
                    label_value = self.labels[label]
                    if label_value >= 1024:
                        raise iarm.exceptions.IarmError("Label {} has value {} and is greater than 1020".format(label, label_value))
                    if label_value % 4 != 0:
                        raise iarm.exceptions.IarmError("Lable {} has value {} and is not word aligned".format(label, label_value))
                    label = label_value  # TODO All converted values should be label_value
                except KeyError:
                    # Label doesn't exist, nothing we can do about that except maybe raise an exception now,
                    # But we're avoiding that elsewhere, might as well avoid it here too
                    pass

            def LDR_func():
                # TODO dont overload label, make a new variable
                try:
                    self.register[Ra] = int(label)
                except ValueError:
                    self.register[Ra] = self.labels[label]

            return LDR_func

        if self.is_immediate(Rc):
            if Rb == 'SP' or Rb == 'R15':
                self.check_arguments(low_registers=(Ra,), imm10_4=(Rc,))
            else:
                self.check_arguments(low_registers=(Ra, Rb), imm7_4=(Rc,))

            def LDR_func():
                # TODO does memory read up?
                if (self.register[Rb] + self.convert_to_integer(Rc[1:])) % 4 != 0:
                    raise iarm.exceptions.HardFault("Memory access not word aligned; Register: {}  Immediate: {}".format(self.register[Rb], self.convert_to_integer(Rc[1:])))
                self.register[Ra] = 0
                for i in range(4):
                    self.register[Ra] |= (self.memory[self.register[Rb] + self.convert_to_integer(Rc[1:]) + i] << (8 * i))
        else:
            self.check_arguments(low_registers=(Ra, Rb, Rc))

            def LDR_func():
                # TODO does memory read up?
                if (self.register[Rb] + self.register[Rc]) % 4 != 0:
                    raise iarm.exceptions.HardFault(
                        "Memory access not word aligned; Register: {}  Immediate: {}".format(self.register[Rb],
                                                                                             self.convert_to_integer(
                                                                                                 Rc[1:])))
                self.register[Ra] = 0
                for i in range(4):
                    self.register[Ra] |= (self.memory[self.register[Rb] + self.register[Rc] + i] << (8 * i))

        return LDR_func

    def LDRB(self, params):
        """
        LDRB Ra, [Rb, Rc]
        LDRB Ra, [Rb, #imm5]

        Load a byte from memory into Ra
        Ra, Rb, and Rc must be low registers
        """
        try:
            Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_WITH_BRACKETS, params)
        except iarm.exceptions.ParsingError:
            # LDRB Rn, [Rk] translates to an offset of zero
            Ra, Rb = self.get_two_parameters(r'\s*([^\s,]*),\s*\[([^\s,]*)\](,\s*[^\s,]*)*\s*', params)
            Rc = '#0'

        if self.is_immediate(Rc):
            self.check_arguments(low_registers=(Ra, Rb), imm5=(Rc,))

            def LDRB_func():
                self.register[Ra] = self.memory[self.register[Rb] + self.convert_to_integer(Rc[1:])]
        else:
            self.check_arguments(low_registers=(Ra, Rb, Rc))

            def LDRB_func():
                self.register[Ra] = self.memory[self.register[Rb] + self.register[Rc]]

        return LDRB_func

    def LDRH(self, params):
        """
        LDRH Ra, [Rb, Rc]
        LDRH Ra, [Rb, #imm6_2]

        Load a half word from memory into Ra
        Ra, Rb, and Rc must be low registers
        """
        try:
            Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_WITH_BRACKETS, params)
        except iarm.exceptions.ParsingError:
            # LDRB Rn, [Rk] translates to an offset of zero
            Ra, Rb = self.get_two_parameters(r'\s*([^\s,]*),\s*\[([^\s,]*)\](,\s*[^\s,]*)*\s*', params)
            Rc = '#0'

        if self.is_immediate(Rc):
            self.check_arguments(low_registers=(Ra, Rb), imm6_2=(Rc,))

            def LDRH_func():
                # TODO does memory read up?
                if (self.register[Rb]) % 2 != 0:
                    raise iarm.exceptions.HardFault(
                        "Memory access not half word aligned; Register: {}  Immediate: {}".format(self.register[Rb],
                                                                                                  self.convert_to_integer(
                                                                                                      Rc[1:])))
                self.register[Ra] = 0
                for i in range(2):
                    self.register[Ra] |= (self.memory[self.register[Rb] + self.convert_to_integer(Rc[1:]) + i] << (8 * i))
        else:
            self.check_arguments(low_registers=(Ra, Rb, Rc))

            def LDRH_func():
                # TODO does memory read up?
                if (self.register[Rb] + self.register[Rc]) % 2 != 0:
                    raise iarm.exceptions.HardFault(
                        "Memory access not half word aligned; Register: {}  Immediate: {}".format(self.register[Rb],
                                                                                                  self.register[Rc]))
                self.register[Ra] = 0
                for i in range(2):
                    self.register[Ra] |= (self.memory[self.register[Rb] + self.register[Rc] + i] << (8 * i))

        return LDRH_func

    def LDRSB(self, params):
        """
        LDRSB Ra, [Rb, Rc]

        Load a byte from memory, sign extend, and put into Ra
        Ra, Rb, and Rc must be low registers
        """
        # TODO LDRSB cant use immediates
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_WITH_BRACKETS, params)

        self.check_arguments(low_registers=(Ra, Rb, Rc))

        def LDRSB_func():
            # TODO does memory read up?
            self.register[Ra] = 0
            self.register[Ra] |= self.memory[self.register[Rb] + self.register[Rc]]
            if self.register[Ra] & (1 << 7):
                self.register[Ra] |= (0xFFFFFF << 8)

        return LDRSB_func

    def LDRSH(self, params):
        """
        LDRSH Ra, [Rb, Rc]

        Load a half word from memory, sign extend, and put into Ra
        Ra, Rb, and Rc must be low registers
        """
        # TODO LDRSH cant use immediates
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_WITH_BRACKETS, params)

        self.check_arguments(low_registers=(Ra, Rb, Rc))

        def LDRSH_func():
            # TODO does memory read up?
            if (self.register[Rb] + self.register[Rc]) % 2 != 0:
                raise iarm.exceptions.HardFault(
                    "Memory access not half word aligned\nR{}: {}\nR{}: {}".format(Rb, self.register[Rb],
                                                                                   Rc, self.register[Rc]))
            self.register[Ra] = 0
            for i in range(2):
                self.register[Ra] |= (self.memory[self.register[Rb] + self.register[Rc] + i] << (8 * i))
            if self.register[Ra] & (1 << 15):
                self.register[Ra] |= (0xFFFF << 16)

        return LDRSH_func

    def POP(self, params):
        """
        POP {RPopList}

        Pop from the stack into the list of registers
        List must contain only low registers or PC
        """
        # TODO verify pop order
        # TODO pop list is comma separate, right?
        # TODO what registeres are allowed to POP to? Low Registers and PC
        # TODO need to support ranges, ie {R2, R5-R7}
        # TODO PUSH should reverse the list, not POP
        RPopList = self.get_one_parameter(r'\s*{(.*)}(.*)', params).split(',')
        RPopList.reverse()
        RPopList = [i.strip() for i in RPopList]

        def POP_func():
            for register in RPopList:
                # Get 4 bytes
                value = 0
                for i in range(4):
                    # TODO use memory width instead of constants
                    value |= self.memory[self.register['SP'] + i] << (8 * i)

                self.register[register] = value
                self.register['SP'] += 4

        return POP_func

    def PUSH(self, params):
        """
        PUSH {RPushList}

        Push to the stack from a list of registers
        List must contain only low registers or LR
        """
        # TODO what registers are allowed to PUSH to? Low registers and LR
        # TODO PUSH should reverse the list, not POP
        RPushList = self.get_one_parameter(r'\s*{(.*)}(.*)', params).split(',')
        RPushList = [i.strip() for i in RPushList]

        def PUSH_func():
            for register in RPushList:
                self.register['SP'] -= 4

                for i in range(4):
                    # TODO is this the same as with POP?
                    self.memory[self.register['SP'] + i] = ((self.register[register] >> (8 * i)) & 0xFF)

        return PUSH_func

    def STM(self, params):
        """
        STM Ra!, {RLoList}

        Store multiple registers into memory
        """
        # TODO what registers can be stored?
        Ra, RLoList = self.get_two_parameters(r'\s*([^\s,]*)!,\s*{(.*)}(.*)', params).split(',')
        RLoList = RLoList.split(',')
        RLoList = [i.strip() for i in RLoList]

        self.check_arguments(low_registers=[Ra] + RLoList)

        def STM_func():
            for i in range(len(RLoList)):
                for j in range(4):
                    self.memory[self.register[Ra] + 4*i + j] = ((self.register[RLoList[i]] >> (8 * j)) & 0xFF)
            self.register[Ra] += 4*len(RLoList)

        return STM_func

    def STR(self, params):
        """
        STR Ra, [Rb, Rc]
        STR Ra, [Rb, #imm7_4]
        STR Ra, [SP, #imm10_4]

        Store Ra into memory as a word
        Ra, Rb, and Rc must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_WITH_BRACKETS, params)

        if self.is_immediate(Rc):
            if Rb == 'SP':
                self.check_arguments(low_registers=(Ra,), imm10_4=(Rc,))
            else:
                self.check_arguments(low_registers=(Ra, Rb), imm7_4=(Rc,))

            def STR_func():
                for i in range(4):
                    self.memory[self.register[Rb] + self.convert_to_integer(Rc[1:]) + i] = ((self.register[Ra] >> (8 * i)) & 0xFF)
        else:
            self.check_arguments(low_registers=(Ra, Rb, Rc))

            def STR_func():
                for i in range(4):
                    self.memory[self.register[Rb] + self.register[Rc] + i] = ((self.register[Ra] >> (8 * i)) & 0xFF)

        return STR_func

    def STRB(self, params):
        """
        STRB Ra, [Rb, Rc]
        STRB Ra, [Rb, #imm5]

        Store Ra into memory as a byte
        Ra, Rb, and Rc must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_WITH_BRACKETS, params)

        if self.is_immediate(Rc):
            self.check_arguments(low_registers=(Ra, Rb), imm5=(Rc,))

            def STRB_func():
                self.memory[self.register[Rb] + self.convert_to_integer(Rc[1:])] = (self.register[Ra] & 0xFF)
        else:
            self.check_arguments(low_registers=(Ra, Rb, Rc))

            def STRB_func():
                self.memory[self.register[Rb] + self.register[Rc]] = (self.register[Ra] & 0xFF)

        return STRB_func

    def STRH(self, params):
        """
        STRH Ra, [Rb, Rc]
        STRH Ra, [Rb, #imm6_2]

        Store Ra into memory as a half word
        Ra, Rb, and Rc must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_WITH_BRACKETS, params)

        if self.is_immediate(Rc):
            self.check_arguments(low_registers=(Ra, Rb), imm5=(Rc,))

            def STRH_func():
                for i in range(2):
                    self.memory[self.register[Rb] + self.convert_to_integer(Rc[1:]) + i] = ((self.register[Ra] >> (8 * i)) & 0xFF)
        else:
            self.check_arguments(low_registers=(Ra, Rb, Rc))

            def STRH_func():
                for i in range(2):
                    self.memory[self.register[Rb] + self.register[Rc] + i] = ((self.register[Ra] >> (8 * i)) & 0xFF)

        return STRH_func
