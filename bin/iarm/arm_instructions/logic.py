import iarm.exceptions
from ._meta import _Meta


class Logic(_Meta):
    def ANDS(self, params):
        """
        ANDS Ra, Ra, Rb

        AND Ra and Rb together and store the result in Ra
        The equivalent of `Ra = Ra & Rb`
        Updates NZ flags
        Ra and Rb must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rc))
        self.match_first_two_parameters(Ra, Rb)

        # ANDS Ra, Ra, Rb
        def ANDS_func():
            self.register[Ra] = self.register[Ra] & self.register[Rc]
            self.set_NZ_flags(self.register[Ra])

        return ANDS_func

    def BICS(self, params):
        """
        BICS Ra, Ra, Rb

        Flip the bits in Rb and AND the result with Ra, storing the result in Ra
        The equivalent of `Ra = Ra & ~Rb`
        Updates NZ flags
        Ra and Rb must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(self.THREE_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rc))
        self.match_first_two_parameters(Ra, Rb)

        # BICS Ra, Ra, Rb
        def BICS_func():
            self.register[Ra] = self.register[Ra] & (~self.register[Rc])
            self.set_NZ_flags(self.register[Ra])

        return BICS_func

    def EORS(self, params):
        """
        EORS Ra, Ra, Rb

        Exclusive OR Ra and Rb together and store the result in Ra
        The equivalent of `Ra = Ra ^ Rc`
        Updates NZ flags
        Ra and Rb must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(r'\s*([^\s,]*),\s*([^\s,]*)(,\s*[^\s,]*)*\s*', params)

        self.check_arguments(low_registers=(Ra, Rc))
        self.match_first_two_parameters(Ra, Rb)

        # EORS Ra, Ra, Rb
        def EORS_func():
            self.register[Ra] = self.register[Ra] ^ self.register[Rc]
            self.set_NZ_flags(self.register[Ra])

        return EORS_func

    def ORRS(self, params):
        """
        ORRS Ra, Ra, Rb

        OR Ra and Rb together and store the result in Ra
        The equivalent of `Ra = Ra | Rc`
        Updates NZ flags
        Ra and Rb must be low registers
        """
        Ra, Rb, Rc = self.get_three_parameters(r'\s*([^\s,]*),\s*([^\s,]*)(,\s*[^\s,]*)*\s*', params)

        self.check_arguments(low_registers=(Ra, Rc))
        self.match_first_two_parameters(Ra, Rb)

        # ORRS Ra, Ra, Rb
        def ORRS_func():
            self.register[Ra] = self.register[Ra] | self.register[Rc]
            self.set_NZ_flags(self.register[Ra])

        return ORRS_func

    def TST(self, params):
        """
        TST Ra, Rb

        AND Ra and Rb together and update the NZ flag. The result is not set
        The equivalent of `Ra & Rc`
        Ra and Rb must be low registers
        """
        Ra, Rb = self.get_two_parameters(self.TWO_PARAMETER_COMMA_SEPARATED, params)

        self.check_arguments(low_registers=(Ra, Rb))

        def TST_func():
            result = self.register[Ra] & self.register[Rb]
            self.set_NZ_flags(result)

        return TST_func
