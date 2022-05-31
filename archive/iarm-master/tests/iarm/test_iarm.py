import unittest
import iarm.arm
import iarm.exceptions
import random


class TestArm(unittest.TestCase):
    """The base class for all arm tests"""
    def setUp(self):
        self.interp = iarm.arm.Arm(1024, False)


class TestArmChecks(TestArm):
    def test_is_register(self):
        self.assertTrue(self.interp.is_register('R0'))
        #self.assertTrue(self.interp.is_register('R0xF')) Cannot use hex or binary for register access
        self.assertFalse(self.interp.is_register('#0'))
        self.assertFalse(self.interp.is_register('#0x1'))

    def test_is_immediate(self):
        self.assertFalse(self.interp.is_immediate('R0'))
        self.assertFalse(self.interp.is_immediate('R0xF'))
        self.assertTrue(self.interp.is_immediate('#0'))
        self.assertTrue(self.interp.is_immediate('#0x1'))

    def test_check_register(self):
        self.assertEqual(self.interp.check_register('R0'), 0)
        self.assertEqual(self.interp.check_register('R1'), 1)
        self.assertEqual(self.interp.check_register('R15'), 15)
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_register('R')
            self.interp.check_register('R0x5')
            self.interp.check_register('R0xE')

    def test_check_immediate(self):
        self.assertEqual(self.interp.check_immediate('#0'), 0)
        self.assertEqual(self.interp.check_immediate('#1'), 1)
        self.assertEqual(self.interp.check_immediate('#15'), 15)
        self.assertEqual(self.interp.check_immediate('#0x5'), 5)
        self.assertEqual(self.interp.check_immediate('#0x70'), 112)
        self.assertEqual(self.interp.check_immediate('#2_0011'), 3)
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_immediate('#')
        with self.assertRaises(ValueError):
            self.interp.check_immediate('#0xFG')
        with self.assertRaises(ValueError):
            self.interp.check_immediate('#2_012')

    @unittest.skip("How to best test this")
    def test_check_immediate_unsiged_value(self):
        self.fail("How to best test this")

    @unittest.skip("How to best test this")
    def test_check_immediate_value(self):
        self.fail("How to best test this")

    def test_check_multiple_of(self):
        self.interp.check_multiple_of(0, 2)
        self.interp.check_multiple_of(8, 4)
        self.interp.check_multiple_of(64, 8)
        self.interp.check_multiple_of(1234, 2)
        self.interp.check_multiple_of(6, 3)
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_multiple_of(1, 2)
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_multiple_of(4, 3)


class TestArmRules(TestArm):
    """
    Test all validation rules
    """
    @unittest.skip('Currently there are no instructions to test that raise this type of exception')
    def test_parameter_none(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.evaluate(' MOVS')

    def test_parameter_not_register(self):
        with self.assertRaises(iarm.exceptions.RuleError) as cm:
            self.interp.evaluate(' MOVS #1, #3')
        self.assertIn('not a register', str(cm.exception))

    def test_parameter_register_not_defined(self):
        with self.assertRaises(iarm.exceptions.RuleError) as cm:
            self.interp.evaluate(' MOVS R{}, #3'.format(self.interp._max_registers+1))
        self.assertIn('greater', str(cm.exception))

    def test_parameter_not_an_immediate(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm8=('R4',))

    @unittest.skip('Currently there are no instructions to test that raise this type of exception')
    def test_parameter_not_an_immediate_unsigned(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            pass

    def test_parameter_immediate_out_of_range(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm8=('#1234',))

    def test_parameter_immediate_not_multiple_of(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm6_2=('#3',))
            self.interp.check_arguments(imm7_4=('#6',))

    def test_rule_low_register(self):
        self.interp.check_arguments(low_registers=('R0', 'R7'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(low_registers=('R8',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(low_registers=('#1',))

    def test_rule_high_register(self):
        self.interp.check_arguments(high_registers=('R8', 'R12'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(high_registers=('R0',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(high_registers=('R13',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(high_registers=('#1',))

    def test_rule_general_purpose_register(self):
        self.interp.check_arguments(general_purpose_registers=('R0', 'R12'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(general_purpose_registers=('R13',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(general_purpose_registers=('#1',))

    def test_rule_any_register(self):
        # TODO does this also mean PC, LR, and SP?
        self.interp.check_arguments(any_registers=('R0', 'R15'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(any_registers=('R16',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(any_registers=('#1',))

    def test_rule_imm3(self):
        self.interp.check_arguments(imm3=('#0', '#1', '#7', '#0x2'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm3=('R0',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm3=('#8',))

    def test_rule_imm5(self):
        # [0, 31]
        self.interp.check_arguments(imm5=('#0', '#1', '#31', '#0xF'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm5=('R0',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm5=('#32',))

    def test_rule_imm5_counting(self):
        # [1, 32]
        self.interp.check_arguments(imm5_counting=('#1', '#32', '#0xE'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm5_counting=('R0',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm5_counting=('#33',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm5_counting=('#0',))

    def test_rule_imm6_2(self):
        self.interp.check_arguments(imm6_2=('#0', '#2', '#62', '#0xC'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm6_2=('R0',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm6_2=('#1',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm6_2=('#63',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm6_2=('#64',))

    def test_rule_imm7_4(self):
        self.interp.check_arguments(imm7_4=('#0', '#4', '#124', '#0x14'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm7_4=('R0',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm7_4=('#1',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm7_4=('#127',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm7_4=('#128',))

    def test_rule_imm8(self):
        self.interp.check_arguments(imm8=('#0', '#1', '#255', '#0xF1'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm8=('R0',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm8=('#256',))

    @unittest.skip("Not sure how to encode negative numbers")
    def test_rule_immS8_2(self):
        # TODO how is a negative number encoded?
        self.fail("Not sure how to encode negative numbers")

    def test_rule_imm9_4(self):
        self.interp.check_arguments(imm9_4=('#0', '#4', '#508', '#0x100'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm9_4=('R0',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm9_4=('#1',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm9_4=('#511',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm9_4=('#512',))

    def test_rule_imm10_4(self):
        self.interp.check_arguments(imm10_4=('#0', '#4', '#1020', '#0x3f8'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm10_4=('R0',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm10_4=('#1',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm10_4=('#1023',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(imm10_4=('#1024',))

    @unittest.skip("Not sure how to encode negative numbers")
    def test_rule_immS25_2(self):
        # TODO how is a negative number encoded?
        self.fail("Not sure how to encode negative numbers")

    @unittest.expectedFailure
    def test_rule_special_register(self):
        # http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0588b/Cihibbbh.html
        # TODO This list does not contain the PSR, but is it a valid code to read from?
        # TODO it's here: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0211k/ch02s08s01.html
        self.interp.check_arguments(special_registers=('APSR', 'IPSR', 'EPSR', 'IEPSR',
                                                       'IAPSR', 'EAPSR', 'XPSR', 'MSP',
                                                       'PSP',
                                                       'PRIMASK', 'BASEPRI', 'BASEPRI_MAX'
                                                       'FAULTMASK', 'CONTROL'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(special_registers=('R0'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(special_registers=('#0'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(special_registers=('R15'))

    def test_rule_LR_or_general_purpose_registers(self):
        self.interp.check_arguments(LR_or_general_purpose_registers=('R0', 'R1', 'R12', 'LR'))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(LR_or_general_purpose_registers=('R13',))
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.check_arguments(LR_or_general_purpose_registers=('#1',))


class TestArmRegisters(TestArm):
    """
    Make sure that PC, LR, and SP are linked to R15, R14, and R13 respectively
    """
    def test_PC_register_link(self):
        REG1 = 'PC'
        REG2 = 'R15'
        self.assertEqual(self.interp.register[REG1], self.interp.register[REG2])
        self.interp.register[REG1] = 0
        self.assertEqual(self.interp.register[REG1], self.interp.register[REG2])
        self.interp.register[REG2] = 1
        self.assertEqual(self.interp.register[REG1], 1)
        self.interp.register[REG1] = random.randint(0, 2**self.interp._bit_width-1)
        self.assertEqual(self.interp.register[REG1], self.interp.register[REG2])

    def test_LR_register_link(self):
        REG1 = 'LR'
        REG2 = 'R14'
        self.assertEqual(self.interp.register[REG1], self.interp.register[REG2])
        self.interp.register[REG1] = 0
        self.assertEqual(self.interp.register[REG1], self.interp.register[REG2])
        self.interp.register[REG2] = 1
        self.assertEqual(self.interp.register[REG1], 1)
        self.interp.register[REG1] = random.randint(0, 2 ** self.interp._bit_width - 1)
        self.assertEqual(self.interp.register[REG1], self.interp.register[REG2])

    def test_SP_register_link(self):
        REG1 = 'SP'
        REG2 = 'R13'
        self.assertEqual(self.interp.register[REG1], self.interp.register[REG2])
        self.interp.register[REG1] = 0
        self.assertEqual(self.interp.register[REG1], self.interp.register[REG2])
        self.interp.register[REG2] = 1
        self.assertEqual(self.interp.register[REG1], 1)
        self.interp.register[REG1] = random.randint(0, 2 ** self.interp._bit_width - 1)
        self.assertEqual(self.interp.register[REG1], self.interp.register[REG2])

    def test_set_APSR_flag_to_value(self):
        self.assertEqual(self.interp.register['APSR'], 0)
        self.interp.set_APSR_flag_to_value('N', 1)
        self.assertEqual(self.interp.register['APSR'], (0b1000 << 28))
        self.interp.set_APSR_flag_to_value('N', 0)
        self.assertEqual(self.interp.register['APSR'], 0)
        self.interp.set_APSR_flag_to_value('N', 1)
        self.interp.set_APSR_flag_to_value('Z', 1)
        self.assertEqual(self.interp.register['APSR'], (0b1100 << 28))
        self.interp.set_APSR_flag_to_value('C', 1)
        self.interp.set_APSR_flag_to_value('V', 1)
        self.assertEqual(self.interp.register['APSR'], (0b1111 << 28))
        self.interp.set_APSR_flag_to_value('N', 0)
        self.assertEqual(self.interp.register['APSR'], (0b0111 << 28))
        self.interp.set_APSR_flag_to_value('V', 0)
        self.assertEqual(self.interp.register['APSR'], (0b0110 << 28))
        self.interp.set_APSR_flag_to_value('Z', 0)
        self.interp.set_APSR_flag_to_value('C', 0)
        self.assertEqual(self.interp.register['APSR'], 0)

    def test_set_N_flag(self):
        self.interp.set_N_flag(-1 & (2**self.interp._bit_width - 1))
        self.assertEqual(self.interp.register['APSR'], (1 << 31))
        self.assertTrue(self.interp.is_N_set())
        self.interp.set_N_flag(0)
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_N_set())
        self.interp.set_N_flag(1)
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_N_set())
        self.interp.set_N_flag(2**self.interp._bit_width - 1)
        self.assertEqual(self.interp.register['APSR'], 1 << 31)
        self.assertTrue(self.interp.is_N_set())
        self.interp.set_N_flag(2 ** (self.interp._bit_width - 2))
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_N_set())
        self.interp.set_N_flag(-2**(self.interp._bit_width - 2) & (2**self.interp._bit_width - 1))
        self.assertEqual(self.interp.register['APSR'], (1 << 31))
        self.assertTrue(self.interp.is_N_set())

    def test_set_Z_flag(self):
        self.interp.set_Z_flag(-1 & (2**self.interp._bit_width - 1))
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_Z_set())
        self.interp.set_Z_flag(0)
        self.assertEqual(self.interp.register['APSR'], (1 << 30))
        self.assertTrue(self.interp.is_Z_set())
        self.interp.set_Z_flag(1)
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_Z_set())
        self.interp.set_Z_flag(2**self.interp._bit_width - 1)
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_Z_set())
        self.interp.set_Z_flag((2**self.interp._bit_width - 1) & (2**self.interp._bit_width - 1))
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_Z_set())

    def test_set_C_flag(self):
        self.interp.set_C_flag(1, 2**self.interp._bit_width - 1, 0, 'add')
        self.assertEqual(self.interp.register['APSR'], (1 << 29))
        self.assertTrue(self.interp.is_C_set())
        self.interp.set_C_flag(1, 1, 2, 'add')
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_C_set())
        self.interp.set_C_flag(2 ** self.interp._bit_width - 2, 3, 1, 'add')
        self.assertEqual(self.interp.register['APSR'], (1 << 29))
        self.assertTrue(self.interp.is_C_set())
        self.interp.set_C_flag(0, 0, 0, 'add')
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_C_set())

        self.interp.set_C_flag(0, 1, 2**self.interp._bit_width - 1, 'sub')
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_C_set())
        self.interp.set_C_flag(2, 1, 1, 'sub')
        self.assertEqual(self.interp.register['APSR'], 1 << 29)
        self.assertTrue(self.interp.is_C_set())
        self.interp.set_C_flag(1, 18, -17 & (2**self.interp._bit_width - 1), 'sub')
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_C_set())
        self.interp.set_C_flag(1, 1, 0, 'sub')
        self.assertEqual(self.interp.register['APSR'], 1 << 29)
        self.assertTrue(self.interp.is_C_set())
        self.interp.set_C_flag(0, 0, 0, 'sub')
        self.assertEqual(self.interp.register['APSR'], 1 << 29)
        self.assertTrue(self.interp.is_C_set())

    def test_set_V_flag(self):
        self.interp.set_V_flag(1, 1, 2, 'add')
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_V_set())
        self.interp.set_V_flag(0x40000000, 0x40000000, 0x80000000, 'add')
        self.assertEqual(self.interp.register['APSR'], 1 << 28)
        self.assertTrue(self.interp.is_V_set())
        self.interp.set_V_flag(0xFFFFFFFF, 0x80000000, 0x7FFFFFFF, 'add')
        self.assertEqual(self.interp.register['APSR'], 1 << 28)
        self.assertTrue(self.interp.is_V_set())

        self.interp.set_V_flag(1, 1, 0, 'sub')
        self.assertEqual(self.interp.register['APSR'], 0)
        self.assertFalse(self.interp.is_V_set())
        self.interp.set_V_flag(0x7FFFFFFF, 0xFFFFFFFF, 0x80000000, 'sub')
        self.assertEqual(self.interp.register['APSR'], 1 << 28)
        self.assertTrue(self.interp.is_V_set())

    def test_set_NZCV_flags(self):
        # Table taken from
        # http://stackoverflow.com/questions/8965923/carry-overflow-subtraction-in-x86
        x7F = 0x7FFFFFFF
        xFF = 0xFFFFFFFF
        x80 = 0x80000000
        xFE = 0xFFFFFFFE
        x7E = 0x7FFFFFFE
        add_test_table = [
            [x7F, 0x0, x7F, 0],
            [xFF, x7F, x7E, 0b0010 << 28],  # C
            [0x0, 0x0, 0x0, 0b0100 << 28],  # Z
            [xFF, 0x1, 0x0, 0b0110 << 28],  # ZC
            [xFF, 0x0, xFF, 0b1000 << 28],  # N
            [xFF, xFF, xFE, 0b1010 << 28],  # NC
            [xFF, x80, x7F, 0b0011 << 28],  # CV
            [x80, x80, 0x0, 0b0111 << 28],  # ZCV
            [x7F, x7F, xFE, 0b1001 << 28]   # NV
        ]
        sub_test_table = [
            [xFF, xFE, 0x1, 0b0010 << 28],  # The carry bit is set when we did not borrow
            [x7E, xFF, x7F, 0],  # C (we borrowed)
            [xFF, xFF, 0x0, 0b0110 << 28],  # Z
            [xFF, x7F, x80, 0b1010 << 28],  # N
            [xFE, xFF, xFF, 0b1000 << 28],  # NC
            [xFE, x7F, x7F, 0b0011 << 28],  # V
            [x7F, xFF, x80, 0b1001 << 28]   # NCV
        ]
        for row in add_test_table:
            self.interp.set_NZCV_flags(row[0], row[1], row[2], 'add')
            self.assertEqual(self.interp.register['APSR'], row[3],
                             msg="Fail with {0:X} + {0:X} = {0:X}; {0:X}".format(row[0], row[1], row[2], row[3]))

        for row in sub_test_table:
            self.interp.set_NZCV_flags(row[0], row[1], row[2], 'sub')
            self.assertEqual(self.interp.register['APSR'], row[3])

if __name__ == '__main__':
    unittest.main()
