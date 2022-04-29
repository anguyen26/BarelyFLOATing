from .test_iarm import TestArm
import iarm.exceptions
import unittest


class TestArmDataMovement(TestArm):
    def test_MOV(self):
        self.interp.register['R0'] = 5
        self.interp.register['R1'] = 0
        self.assertEqual(self.interp.register['R1'], 0)

        self.interp.evaluate(" MOV R1, R0")
        self.interp.run()

        self.assertEqual(self.interp.register['R1'], 5)

    def test_MOV_imm(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.evaluate(" MOV R1, #3")

    # TODO test high and special registers

    def test_MOVS_zero_register(self):
        self.interp.register['R0'] = 5
        self.interp.register['R1'] = 0
        self.assertEqual(self.interp.register['R0'], 5)

        self.interp.evaluate(" MOVS R0, R1")
        self.interp.run()

        self.assertEqual(self.interp.register['R0'], 0)
        self.assertTrue(self.interp.register['APSR'] & (1 << 30))
        self.assertFalse(self.interp.register['APSR'] & (1 << 31))

    def test_MOVS_zero_imm(self):
        self.interp.register['R0'] = 5
        self.assertEqual(self.interp.register['R0'], 5)

        self.interp.evaluate(" MOVS R0, #0")
        self.interp.run()

        self.assertEqual(self.interp.register['R0'], 0)
        self.assertTrue(self.interp.register['APSR'] & (1 << 30))
        self.assertFalse(self.interp.register['APSR'] & (1 << 31))

    def test_MOVS_negative_register(self):
        self.interp.register['R0'] = 0
        self.interp.register['R1'] = -1
        self.assertEqual(self.interp.register['R0'], 0)

        self.interp.evaluate(" MOVS R0, R1")
        self.interp.run()

        self.assertEqual(self.interp.register['R0'], -1 & 2**self.interp._bit_width-1)
        self.assertFalse(self.interp.register['APSR'] & (1 << 30))
        self.assertTrue(self.interp.register['APSR'] & (1 << 31))

    def test_MOVS_positive_register(self):
        self.interp.register['R1'] = 0
        self.interp.register['R1'] = 5
        self.assertEqual(self.interp.register['R0'], 0)

        self.interp.evaluate(" MOVS R0, R1")
        self.interp.run()

        self.assertEqual(self.interp.register['R0'], 5)
        self.assertFalse(self.interp.register['APSR'] & (1 << 30))
        self.assertFalse(self.interp.register['APSR'] & (1 << 31))

    def test_MOVS_positive_imm(self):
        self.interp.register['R1'] = 0
        self.assertEqual(self.interp.register['R0'], 0)

        self.interp.evaluate(" MOVS R0, #5")
        self.interp.run()

        self.assertEqual(self.interp.register['R0'], 5)
        self.assertFalse(self.interp.register['APSR'] & (1 << 30))
        self.assertFalse(self.interp.register['APSR'] & (1 << 31))

    def test_MOVS_high_register(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.evaluate(" MOVS R9, R1")

    def test_MRS_low_register(self):
        self.interp.evaluate(" MOVS R0, #0")  # Set the Z flag
        self.interp.evaluate(" MRS R1, APSR")
        self.interp.run()

        self.assertEqual(self.interp.register['APSR'], (1 << 30))
        self.assertEqual(self.interp.register['R1'], (1 << 30))

    def test_MRS_LR_register(self):
        self.interp.evaluate(" MOVS R0, #0")  # Set the Z flag
        self.interp.evaluate(" MRS LR, APSR")
        self.interp.run()

        self.assertEqual(self.interp.register['APSR'], (1 << 30))
        self.assertEqual(self.interp.register['LR'], (1 << 30))

    def test_MRS_PSR(self):
        self.interp.evaluate(" MOVS R0, #0")  # Set the Z flag
        self.interp.evaluate(" MRS R14, PSR")  # R14 is also LR
        self.interp.run()

        self.assertEqual(self.interp.register['APSR'], (1 << 30))
        self.assertEqual(self.interp.register['R14'], (1 << 30))

    def test_MSR_register(self):
        self.interp.register['R0'] = (15 << 28)
        self.interp.evaluate(" MSR APSR, R0")
        self.interp.run()

        self.assertEqual(self.interp.register['APSR'], (15 << 28))

    def test_MVNS(self):
        self.interp.register['R0'] = -5
        self.interp.evaluate(" MVNS R1, R0")
        self.interp.evaluate(" MVNS R2, R1")
        self.interp.run()

        self.assertEqual(self.interp.register['R1'], 4)
        self.assertEqual(self.interp.register['R2'], -5 & 2**self.interp._bit_width-1)

    def test_MVNS_high_register(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.evaluate(" MVNS R9, R0")

    def test_REV(self):
        self.interp.register['R7'] = 0x12345678
        self.interp.register['R5'] = 0x0F
        self.interp.evaluate(" REV R6, R7")
        self.interp.evaluate(" REV R4, R5")
        self.interp.run()

        self.assertEqual(self.interp.register['R6'], 0x78563412)
        self.assertEqual(self.interp.register['R4'], 0x0F000000)

    def test_REV_high_register(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.evaluate(" REV R4, R10")

    def test_REV16(self):
        self.interp.register['R7'] = 0x12345678
        self.interp.register['R5'] = 0x0F
        self.interp.evaluate(" REV16 R6, R7")
        self.interp.evaluate(" REV16 R4, R5")
        self.interp.run()

        self.assertEqual(self.interp.register['R6'], 0x34127856)
        self.assertEqual(self.interp.register['R4'], 0x00000F00)

    def test_REV16_high_register(self):
        with self.assertRaises(iarm.exceptions.RuleError):
            self.interp.evaluate(" REV R2, R11")

    def test_REVSH(self):
        self.interp.register['R7'] = 0x00001188
        self.interp.register['R5'] = 0xFFFFFF00
        self.interp.evaluate(" REVSH R6, R7")
        self.interp.evaluate(" REVSH R4, R5")
        self.interp.run()

        self.assertEqual(self.interp.register['R6'], 0xFFFF8811)
        self.assertEqual(self.interp.register['R4'], 0x000000FF)

    def test_SXTB(self):
        test_set = [[0, 0],
                    [1, 1],
                    [127, 127],
                    [128, 0xFFFFFF80],
                    [255, 0xFFFFFFFF],
                    [256, 0]]

        for row in test_set:
            self.interp.register['R1'] = row[0]
            self.interp.evaluate(" SXTB R0, R1")
            self.interp.run()

            self.assertEqual(self.interp.register['R0'], row[1])

    def test_SXTH(self):
        test_set = [[0, 0],
                    [1, 1],
                    [32767, 32767],
                    [32768, 0xFFFF8000],
                    [65535, 0xFFFFFFFF],
                    [65536, 0]]

        for row in test_set:
            self.interp.register['R1'] = row[0]
            self.interp.evaluate(" SXTH R0, R1")
            self.interp.run()

            self.assertEqual(self.interp.register['R0'], row[1])

    def test_UXTB(self):
        test_set = [[0, 0],
                    [1, 1],
                    [127, 127],
                    [128, 128],
                    [255, 255],
                    [256, 0]]

        for row in test_set:
            self.interp.register['R1'] = row[0]
            self.interp.evaluate(" UXTB R0, R1")
            self.interp.run()

            self.assertEqual(self.interp.register['R0'], row[1])

    def test_UXTH(self):
        test_set = [[0, 0],
                    [1, 1],
                    [32767, 32767],
                    [32768, 32768],
                    [65535, 65535],
                    [65536, 0]]

        for row in test_set:
            self.interp.register['R1'] = row[0]
            self.interp.evaluate(" UXTH R0, R1")
            self.interp.run()

            self.assertEqual(self.interp.register['R0'], row[1])

if __name__ == '__main__':
    unittest.main()
