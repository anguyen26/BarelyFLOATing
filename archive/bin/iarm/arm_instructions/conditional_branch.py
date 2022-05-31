from ._meta import _Meta


class ConditionalBranch(_Meta):
    def BCC(self, params):
        """
        BCC label

        Branch to the instruction at label if the C flag is not set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BCC label
        def BCC_func():
            if not self.is_C_set():
                self.register['PC'] = self.labels[label]

        return BCC_func

    def BCS(self, params):
        """
        BCS label

        Branch to the instruction at label if the C flag is set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BCS label
        def BCS_func():
            if self.is_C_set():
                self.register['PC'] = self.labels[label]

        return BCS_func

    def BEQ(self, params):
        """
        BEQ label

        Branch to the instruction at label if the Z flag is set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BEQ label
        def BEQ_func():
            if self.is_Z_set():
                self.register['PC'] = self.labels[label]

        return BEQ_func

    def BGE(self, params):
        """
        BGE label

        Branch to the instruction at label if the N flag is the same as the V flag
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BGE label
        def BGE_func():
            if self.is_N_set() == self.is_V_set():
                self.register['PC'] = self.labels[label]

        return BGE_func

    def BGT(self, params):
        """
        BGT label

        Branch to the instruction at label if the N flag is the same as the V flag and the Z flag is not set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BGT label
        def BGT_func():
            if (self.is_N_set() == self.is_V_set()) and not self.is_Z_set():
                self.register['PC'] = self.labels[label]

        return BGT_func

    def BHI(self, params):
        """
        BHI label

        Branch to the instruction at label if the C flag is set and the Z flag is not set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BHI label
        def BHI_func():
            if self.is_C_set() and not self.is_Z_set():
                self.register['PC'] = self.labels[label]

        return BHI_func

    def BHS(self, params):
        """
        BHS label

        Branch to the instruction at label if the C flag is set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BHS label
        def BHS_func():
            if self.is_C_set():
                self.register['PC'] = self.labels[label]

        return BHS_func

    def BLE(self, params):
        """
        BLE label

        Branch to the instruction at label if the Z flag is set or if the N flag is not the same as the V flag
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BLE label
        def BLE_func():
            if self.is_Z_set() or (self.is_N_set() != self.is_V_set()):
                self.register['PC'] = self.labels[label]

        return BLE_func

    def BLO(self, params):
        """
        BLO label

        Branch to the instruction at label if the C flag is not set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BLO label
        def BLO_func():
            if not self.is_C_set():
                self.register['PC'] = self.labels[label]

        return BLO_func

    def BLS(self, params):
        """
        BLS label

        Branch to the instruction at label if the C flag is not set or the Z flag is set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BLS label
        def BLS_func():
            if (not self.is_C_set()) or self.is_Z_set():
                self.register['PC'] = self.labels[label]

        return BLS_func

    def BLT(self, params):
        """
        BLT label

        Branch to the instruction at label if the N flag is not the same as the V flag
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BLT label
        def BLT_func():
            if self.is_N_set() != self.is_V_set():
                self.register['PC'] = self.labels[label]

        return BLT_func

    def BMI(self, params):
        """
        BMI label

        Branch to the instruction at label if the N flag is set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BMI label
        def BMI_func():
            if self.is_N_set():
                self.register['PC'] = self.labels[label]

        return BMI_func

    def BNE(self, params):
        """
        BNE label

        Branch to the instruction at label if the Z flag is not set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BNE label
        def BNE_func():
            if not self.is_Z_set():
                self.register['PC'] = self.labels[label]

        return BNE_func

    def BPL(self, params):
        """
        BPL label

        Branch to the instruction at label if the N flag is set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BPL label
        def BPL_func():
            if not self.is_N_set():
                self.register['PC'] = self.labels[label]

        return BPL_func

    def BVC(self, params):
        """
        BVC label

        Branch to the instruction at label if the V flag is not set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BVC label
        def BVC_func():
            if not self.is_V_set():
                self.register['PC'] = self.labels[label]

        return BVC_func

    def BVS(self, params):
        """
        BVS label

        Branch to the instruction at label if the V flag is set
        """
        label = self.get_one_parameter(self.ONE_PARAMETER, params)

        self.check_arguments(label_exists=(label,))

        # BVS label
        def BVS_func():
            if self.is_V_set():
                self.register['PC'] = self.labels[label]

        return BVS_func
