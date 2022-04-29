import iarm.exceptions
from ._meta import _Meta


class Arithmetic(_Meta):
    def ADCS(self, params):
        """
        ADCS Ra, Rb, Rc

        Add Rb and Rc + the carry bit and store the result in Ra
        Ra, Rb, and Rc must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rc))
        self.match_first_two_parameters(Ra, Rb)

        # ADCS Ra, Ra, Rb
        def ADCS_func():
            # TODO need to rethink the set_NZCV with the C flag
            oper_1 = self.register[Ra]
            oper_2 = self.register[Rc]
            self.register[Ra] = oper_1 + oper_2
            self.register[Ra] += 1 if self.is_C_set() else 0
            self.set_NZCV_flags(oper_1, oper_2, self.register[Ra], 'add')

        return ADCS_func

    def ADD(self, params):
        """
        ADD Rx, Ry, [Rz, PC]
        ADD Rx, [SP, PC], #imm10_4
        ADD SP, SP, #imm9_4

        Add Ry and Rz and store the result in Rx
        Rx, Ry, and Rz can be any register
        """
        Rx, Ry, Rz = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        if self.is_register(Rz):
            # ADD Rx, Ry, Rz
            self.check_arguments(any_registers=(Rx, Ry, Rz))
            if Rx != Ry:
                raise iarm.exceptions.RuleError("Second parameter {} does not equal first parameter {}". format(Ry, Rx))

            def ADD_func():
                self.register[Rx] = self.register[Ry] + self.register[Rz]
        else:
            if Rx == 'SP':
                # ADD SP, SP, #imm9_4
                self.check_arguments(imm9_4=(Rz,))
                if Rx != Ry:
                    raise iarm.exceptions.RuleError("Second parameter {} is not SP".format(Ry))
            else:
                # ADD Rx, [SP, PC], #imm10_4
                self.check_arguments(any_registers=(Rx,), imm10_4=(Rz,))
                if Ry not in ('SP', 'PC'):
                    raise iarm.exceptions.RuleError("Second parameter {} is not SP or PC".format(Ry))

            def ADD_func():
                self.register[Rx] = self.register[Ry] + self.convert_to_integer(Rz[1:])

        return ADD_func

    def ADDS(self, params):
        """
        ADDS Ra, Rb, Rc
        ADDS Ra, Rb, #imm3
        ADDS Ra, Ra, #imm8

        Add the result of the last two operands and store the result in the first operand.
        Set the NZCV flags
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        if self.is_register(Rc):
            # ADDS Ra, Rb, Rc
            self.check_arguments(low_registers=(Ra, Rb, Rc))

            def ADDS_func():
                oper_1 = self.register[Rb]
                oper_2 = self.register[Rc]
                self.register[Ra] = self.register[Rb] + self.register[Rc]
                self.set_NZCV_flags(oper_1, oper_2, self.register[Ra], 'add')
        elif Ra == Rb:
            # ADDS Ra, Ra, #imm8
            self.check_arguments(low_registers=(Ra,), imm8=(Rc,))
            self.match_first_two_parameters(Ra, Rb)

            def ADDS_func():
                oper_1 = self.register[Ra]
                oper_2 = self.convert_to_integer(Rc[1:])
                self.register[Ra] = self.register[Ra] + oper_2
                self.set_NZCV_flags(oper_1, oper_2, self.register[Ra], 'add')
        else:
            # ADDS Ra, Rb, #imm3
            self.check_arguments(low_registers=(Ra, Rb), imm3=(Rc,))

            def ADDS_func():
                oper_1 = self.register[Rb]
                oper_2 = self.convert_to_integer(Rc[1:])
                self.register[Ra] = self.register[Rb] + oper_2
                self.set_NZCV_flags(oper_1, oper_2, self.register[Ra], 'add')

        return ADDS_func

    def CMN(self, params):
        """
        CMN Ra, Rb

        Add the two registers and set the NZCV flags
        The result is discarded
        Ra and Rb must be low registers
        """
        Ra, Rb = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rb))

        # CMN Ra, Rb
        def CMN_func():
            self.set_NZCV_flags(self.register[Ra], self.register[Rb],
                                self.register[Ra] + self.register[Rb], 'add')

        return CMN_func

    def CMP(self, params):
        """
        CMP Rm, Rn
        CMP Rm, #imm8

        Subtract Rn or imm8 from Rm, set the NZCV flags, and discard the result
        Rm and Rn can be R0-R14
        """
        Rm, Rn = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        if self.is_register(Rn):
            # CMP Rm, Rn
            self.check_arguments(R0_thru_R14=(Rm, Rn))

            def CMP_func():
                self.set_NZCV_flags(self.register[Rm], self.register[Rn],
                                    self.register[Rm] - self.register[Rn], 'sub')
        else:
            # CMP Rm, #imm8
            self.check_arguments(R0_thru_R14=(Rm,), imm8=(Rn,))

            def CMP_func():
                tmp = self.convert_to_integer(Rn[1:])
                self.set_NZCV_flags(self.register[Rm], tmp,
                                    self.register[Rm] - tmp, 'sub')

        return CMP_func

    def MULS(self, params):
        """
        MULS Ra, Rb, Ra

        Multiply Rb and Ra together and store the result in Ra.
        Set the NZ flags.
        Ra and Rb must be low registers
        The first and last operand must be the same register
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rb, Rc))
        if Ra != Rc:
            raise iarm.exceptions.RuleError("Third parameter {} is not the same as the first parameter {}".format(Rc, Ra))

        # MULS Ra, Rb, Ra
        def MULS_func():
            self.register[Ra] = self.register[Rb] * self.register[Rc]
            self.set_NZ_flags(self.register[Ra])

        return MULS_func

    def NOP(self, params):
        """
        NOP

        Perform no operation
        """
        # TODO check for no parameters
        def NOP_func():
            return
        return NOP_func

    def RSBS(self, params):
        """
        RSBS Ra, Rb, #0

        Subtract Rb from zero (0 - Rb) and store the result in Ra
        Set the NZCV flags
        Ra and Rb must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rb))
        if Rc != '#0':
            raise iarm.exceptions.RuleError("Third parameter {} is not #0".format(Rc))
        # RSBS Ra, Rb, #0

        def RSBS_func():
            oper_2 = self.register[Rb]
            self.register[Ra] = 0 - self.register[Rb]
            self.set_NZCV_flags(0, oper_2, self.register[Ra], 'sub')

        return RSBS_func

    def SBCS(self, params):
        """
        SBCS Ra, Rb, Rc

        Subtract Rc from Rb, and one more if the carry flag is set, and place the result in Ra
        Set the NZCV flags
        Ra, Rb, and Rc must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rb, Rc))
        self.match_first_two_parameters(Ra, Rb)

        # SBCS Ra, Ra, Rb
        def SBCS_func():
            # TODO does setting the flags work here?
            oper_1 = self.register[Rb]
            oper_2 = self.register[Rc] + (1 if self.is_C_set() else 0)
            self.register[Ra] = self.register[Rb] - oper_2
            self.set_NZCV_flags(oper_1, oper_2, self.register[Ra], 'sub')

        return SBCS_func

    def SUB(self, params):
        """
        SUB SP, SP, #imm9_4

        Subtract an immediate from the Stack Pointer
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(imm9_4=(Rc,))
        if Ra != 'SP':
            raise iarm.exceptions.RuleError("First parameter {} is not equal to SP".format(Ra))
        if Rb != 'SP':
            raise iarm.exceptions.RuleError("Second parameter {} is not equal to SP".format(Rb))

        # SUB SP, SP, #imm9_4
        def SUB_func():
            self.register[Ra] = self.register[Rb] - self.convert_to_integer(Rc[1:])

        return SUB_func

    def SUBS(self, params):
        """
        SUBS Ra, Rb, Rc
        SUBS Ra, Rb, #imm3
        SUBS Ra, Ra, #imm8

        Subtract Rc or an immediate from Rb and store the result in Ra
        Ra, Rb, and Rc must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        if self.is_register(Rc):
            # SUBS Ra, Rb, Rc
            self.check_arguments(low_registers=(Ra, Rb, Rc))

            def SUBS_func():
                oper_1 = self.register[Rb]
                oper_2 = self.register[Rc]
                self.register[Ra] = self.register[Rb] - self.register[Rc]
                self.set_NZCV_flags(oper_1, oper_2, self.register[Ra], 'sub')
        else:
            if Ra == Rb:
                # SUBS Ra, Ra, #imm8
                self.check_arguments(low_registers=(Ra,), imm8=(Rc,))

                def SUBS_func():
                    oper_1 = self.register[Ra]
                    self.register[Ra] = self.register[Ra] - self.convert_to_integer(Rc[1:])
                    self.set_NZCV_flags(oper_1, self.convert_to_integer(Rc[1:]), self.register[Ra], 'sub')
            else:
                # SUBS Ra, Rb, #imm3
                self.check_arguments(low_registers=(Ra, Rb), imm3=(Rc,))

                def SUBS_func():
                    oper_1 = self.register[Rb]
                    self.register[Ra] = self.register[Rb] - self.convert_to_integer(Rc[1:])
                    self.set_NZCV_flags(oper_1, self.convert_to_integer(Rc[1:]), self.register[Ra], 'sub')

        return SUBS_func
