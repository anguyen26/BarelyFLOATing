"""
This file contains all instructions related to moving data
on the CPU (register to register)
"""

import iarm.exceptions
from ._meta import _Meta


class DataMovement(_Meta):
    def MOV(self, params):
        """
        MOV Rx, Ry
        MOV PC, Ry

        Move the value of Ry into Rx or PC
        """
        Rx, Ry = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(any_registers=(Rx, Ry))

        def MOV_func():
            self.register[Rx] = self.register[Ry]

        return MOV_func

    def MOVS(self, params):
        """
        MOVS Ra, Rb
        MOVS Ra, #imm8

        Move the value of Rb or imm8 into Ra
        Ra and Rb must be low registers
        """
        Ra, Rb = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        if self.is_immediate(Rb):
            self.check_arguments(low_registers=[Ra], imm8=[Rb])

            def MOVS_func():
                self.register[Ra] = self.convert_to_integer(Rb[1:])

                # Set N and Z status flags
                self.set_NZ_flags(self.register[Ra])

            return MOVS_func
        elif self.is_register(Rb):
            self.check_arguments(low_registers=(Ra, Rb))

            def MOVS_func():
                self.register[Ra] = self.register[Rb]

                self.set_NZ_flags(self.register[Ra])

            return MOVS_func
        else:
            raise iarm.exceptions.ParsingError("Unknown parameter: {}".format(Rb))

    def MRS(self, params):
        """
        MRS Rj, Rspecial

        Copy the value of Rspecial to Rj
        Rspecial can be APSR, IPSR, or EPSR
        """
        Rj, Rspecial = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(LR_or_general_purpose_registers=(Rj,), special_registers=(Rspecial,))

        def MRS_func():
            # TODO add combination registers IEPSR, IAPSR, and EAPSR
            # TODO needs to use APSR, IPSR, EPSR, IEPSR, IAPSR, EAPSR, PSR, MSP, PSP, PRIMASK, or CONTROL.
            # http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0553a/CHDBIBGJ.html
            if Rspecial == 'PSR':
                self.register[Rj] = self.register['APSR'] | self.register['IPSR'] | self.register['EPSR']
            else:
                self.register[Rj] = self.register[Rspecial]

        return MRS_func

    def MSR(self, params):
        """
        MSR Rspecial, Rj

        Copy the value of Rj to Rspecial
        Rspecial can be APSR, IPSR, or EPSR
        """
        Rspecial, Rj = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(LR_or_general_purpose_registers=(Rj,), special_registers=(Rspecial,))

        def MSR_func():
            # TODO add combination registers IEPSR, IAPSR, and EAPSR
            # http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0553a/CHDBIBGJ.html
            # TODO update N Z C V flags
            if Rspecial in ('PSR', 'APSR'):
                # PSR ignores writes to IPSR and EPSR
                self.register['APSR'] = self.register[Rj]
            else:
                # Do nothing
                pass

        return MSR_func

    def MVNS(self, params):
        """
        MVNS Ra, Rb

        Negate the value in Rb and store it in Ra
        Ra and Rb must be a low register
        """
        Ra, Rb = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rb))

        def MVNS_func():
            self.register[Ra] = ~self.register[Rb]
            self.set_NZ_flags(self.register[Ra])

        return MVNS_func

    def REV(self, params):
        """
        REV Ra, Rb

        Reverse the byte order in register Rb and store the result in Ra
        """
        Ra, Rb = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rb))

        def REV_func():
            self.register[Ra] = ((self.register[Rb] & 0xFF000000) >> 24) | \
                                ((self.register[Rb] & 0x00FF0000) >> 8) | \
                                ((self.register[Rb] & 0x0000FF00) << 8) | \
                                ((self.register[Rb] & 0x000000FF) << 24)

        return REV_func

    def REV16(self, params):
        """
        REV16 Ra, Rb

        Reverse the byte order of the half words in register Rb and store the result in Ra
        """
        Ra, Rb = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rb))

        def REV16_func():
            self.register[Ra] = ((self.register[Rb] & 0xFF00FF00) >> 8) | \
                                ((self.register[Rb] & 0x00FF00FF) << 8)

        return REV16_func

    def REVSH(self, params):
        """
        REVSH

        Reverse the byte order in the lower half word in Rb and store the result in Ra.
        If the result of the result is signed, then sign extend
        """
        Ra, Rb = self.get_two_parameters(r'\s*([^\s,]*),\s*([^\s,]*)(,\s*[^\s,]*)*\s*', params)

        self.check_arguments(low_registers=(Ra, Rb))

        def REVSH_func():
            self.register[Ra] = ((self.register[Rb] & 0x0000FF00) >> 8) | \
                                ((self.register[Rb] & 0x000000FF) << 8)
            if self.register[Ra] & (1 << 15):
                self.register[Ra] |= 0xFFFF0000

        return REVSH_func

    def SXTB(self, params):
        """
        STXB Ra, Rb

        Sign extend the byte in Rb and store the result in Ra
        """
        Ra, Rb = self.get_two_parameters(r'\s*([^\s,]*),\s*([^\s,]*)(,\s*[^\s,]*)*\s*', params)

        self.check_arguments(low_registers=(Ra, Rb))

        def SXTB_func():
            if self.register[Rb] & (1 << 7):
                self.register[Ra] = 0xFFFFFF00 + (self.register[Rb] & 0xFF)
            else:
                self.register[Ra] = (self.register[Rb] & 0xFF)

        return SXTB_func

    def SXTH(self, params):
        """
        STXH Ra, Rb

        Sign extend the half word in Rb and store the result in Ra
        """
        Ra, Rb = self.get_two_parameters(r'\s*([^\s,]*),\s*([^\s,]*)(,\s*[^\s,]*)*\s*', params)

        self.check_arguments(low_registers=(Ra, Rb))

        def SXTH_func():
            if self.register[Rb] & (1 << 15):
                self.register[Ra] = 0xFFFF0000 + (self.register[Rb] & 0xFFFF)
            else:
                self.register[Ra] = (self.register[Rb] & 0xFFFF)

        return SXTH_func

    def UXTB(self, params):
        """
        UTXB Ra, Rb

        Zero extend the byte in Rb and store the result in Ra
        """
        Ra, Rb = self.get_two_parameters(r'\s*([^\s,]*),\s*([^\s,]*)(,\s*[^\s,]*)*\s*', params)

        self.check_arguments(low_registers=(Ra, Rb))

        def UXTB_func():
            self.register[Ra] = (self.register[Rb] & 0xFF)

        return UXTB_func

    def UXTH(self, params):
        """
        UTXH Ra, Rb

        Zero extend the half word in Rb and store the result in Ra
        """
        Ra, Rb = self.get_two_parameters(r'\s*([^\s,]*),\s*([^\s,]*)(,\s*[^\s,]*)*\s*', params)

        self.check_arguments(low_registers=(Ra, Rb))

        def UXTH_func():
            self.register[Ra] = (self.register[Rb] & 0xFFFF)

        return UXTH_func
