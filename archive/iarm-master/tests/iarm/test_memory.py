from .test_iarm import TestArm
import iarm.exceptions
import unittest


class TestArmMemory(TestArm):
    @unittest.skip("ADR not yet implemented")
    def test_ADR(self):
        self.interp.labels['TextMessage'] = 1

        self.interp.evaluate(" ADR R1, TextMessage")
        self.interp.run()

        self.assertEqual(self.interp.register['R1'], 1)

        self.interp.evaluate(" ADR R3, [PC, #996]")
        self.interp.run()

        self.assertEqual(self.interp.register['R3'], 1000)

        with iarm.exceptions.IarmError:
            # Label does not exist
            self.interp.evaluate(" ADR R2, DoesNotExist")

        with iarm.exceptions.IarmError:
            # Register out of range
            self.interp.evaluate(" ADR R8, TextMessage")

        with iarm.exceptions.IarmError:
            # data value within 1020 bytes
            self.interp.evaluate(" ADR R0, [PC, #1024]")

        with iarm.exceptions.IarmError:
            # data value is word aligned
            self.interp.evaluate(" ADR R0, [PC, #3]")

    @unittest.skip('No Test Defined')
    def test_LDM(self):
        pass

    def test_LDR(self):
        self.interp.memory[8] = 0x12
        self.interp.memory[9] = 0x34
        self.interp.memory[10] = 0x56
        self.interp.memory[11] = 0x78
        self.interp.memory[12] = 0x99
        self.interp.register['SP'] = 12
        self.interp.register['R4'] = 4
        self.interp.register['R6'] = 3

        self.interp.evaluate(" LDR R0, [R4, #4]")
        self.interp.run()

        self.assertEqual(self.interp.register['R0'], 0x78563412)

        self.interp.evaluate(" LDR R1, [SP, #0]")
        self.interp.run()

        self.assertEqual(self.interp.register['R1'], 0x00000099)

        self.interp.equates['TEST'] = 0x543210
        self.interp.evaluate(" LDR R2, =TEST")
        self.interp.run()

        self.assertEqual(self.interp.register['R2'], 0x543210)

        self.interp.labels['LABEL'] = 0x1234
        self.interp.evaluate(" LDR R2, =LABEL")
        self.interp.run()

        self.assertEqual(self.interp.register['R2'], 0x1234)

        self.interp.evaluate(" LDR R2, =0x5678")
        self.interp.run()

        self.assertEqual(self.interp.register['R2'], 0x5678)

        self.interp.evaluate(" LDR R2, [SP]")
        self.interp.run()

        self.assertEqual(self.interp.register['R2'], 0x00000099)

        self.interp.labels['SAMPLE'] = 1020
        self.interp.evaluate(" LDR R2, SAMPLE")
        self.interp.run()

        self.assertEqual(self.interp.register['R2'], 1020)

        with self.assertRaises(iarm.exceptions.IarmError):
            # Register within 0-7
            self.interp.evaluate(" LDR R8, [R1]")

        with self.assertRaises(iarm.exceptions.IarmError):
            # data within 0-1020
            self.interp.evaluate(" LDR R7, [R4, #1024]")

        with self.assertRaises(iarm.exceptions.IarmError):
            # data word aligned
            self.interp.evaluate(" LDR R7, [R4, #6]")

        with self.assertRaises(iarm.exceptions.HardFault):
            # address is not word aligned
            self.interp.evaluate(" LDR R7, [R6, #4]")
            self.interp.run()

        with self.assertRaises(iarm.exceptions.IarmError):
            self.interp.labels['NEW'] = 1024
            self.interp.evaluate(" LDR R4, NEW")

    def test_LDRB(self):
        self.interp.memory[8] = 0x12
        self.interp.memory[9] = 0x34
        self.interp.memory[10] = 0x56
        self.interp.memory[11] = 0x78
        self.interp.memory[12] = 0x99
        self.interp.register['R7'] = 8
        self.interp.register['R6'] = 12
        self.interp.register['R5'] = 0
        self.interp.register['R4'] = 4

        self.interp.evaluate(" LDRB R0, [R7]")
        self.interp.run()
        self.assertEqual(self.interp.register['R0'], 0x12)

        self.interp.evaluate(" LDRB R0, [R5, #9]")
        self.interp.run()
        self.assertEqual(self.interp.register['R0'], 0x34)

        self.interp.evaluate(" LDRB R0, [R7, R4]")
        self.interp.run()
        self.assertEqual(self.interp.register['R0'], 0x99)

        with self.assertRaises(iarm.exceptions.IarmError):
            self.interp.evaluate(" LDRB R8, [R7]")
        with self.assertRaises(iarm.exceptions.IarmError):
            self.interp.evaluate(" LDRB R0, [R7, #32]")
        with self.assertRaises(iarm.exceptions.IarmError):
            self.interp.evaluate(" LDRB R0, [SP]")

    def test_LDRH(self):
        self.interp.memory[8] = 0x12
        self.interp.memory[9] = 0x34
        self.interp.memory[10] = 0x56
        self.interp.memory[11] = 0x78
        self.interp.memory[12] = 0x99
        self.interp.memory[13] = 0x88
        self.interp.register['R4'] = 4
        self.interp.register['R6'] = 10
        self.interp.register['R7'] = 4

        self.interp.evaluate(" LDRH R0, [R4, #4]")
        self.interp.run()
        self.assertEqual(self.interp.register['R0'], 0x3412)

        self.interp.evaluate(" LDRH R1, [R6, #2]")
        self.interp.run()
        self.assertEqual(self.interp.register['R1'], 0x8899)

        self.interp.evaluate(" LDRH R2, [R6]")
        self.interp.run()
        self.assertEqual(self.interp.register['R2'], 0x7856)

        self.interp.evaluate(" LDRH R2, [R4, R7]")
        self.interp.run()
        self.assertEqual(self.interp.register['R2'], 0x3412)

        with self.assertRaises(iarm.exceptions.IarmError):
            # Register within 0-7
            self.interp.evaluate(" LDRH R1, [R8, #0]")

        with self.assertRaises(iarm.exceptions.IarmError):
            # data within 0-62
            self.interp.evaluate(" LDRH R7, [R4, #64]")

        with self.assertRaises(iarm.exceptions.IarmError):
            # data half word aligned
            self.interp.evaluate(" LDRH R7, [R4, #3]")

        with self.assertRaises(iarm.exceptions.HardFault):
            # address is not half word aligned
            self.interp.register['R5'] = 5
            self.interp.evaluate(" LDRH R7, [R5, #4]")
            self.interp.run()

        with self.assertRaises(iarm.exceptions.IarmError):
            # Cant use SP and regiser offset
            self.interp.evaluate(" LDRH R7, [SP, R4]")

    def test_LDRSB(self):
        self.interp.memory[0] = 0xFF
        self.interp.memory[1] = 0x7F
        self.interp.memory[5] = 0x21
        self.interp.register['R1'] = 0
        self.interp.register['R2'] = 1
        self.interp.register['R4'] = 4

        self.interp.evaluate(" LDRSB R0, [R2, R1]")
        self.interp.run()
        self.assertEqual(self.interp.register['R0'], 0x0000007F)

        self.interp.evaluate(" LDRSB R0, [R1, R1]")
        self.interp.run()
        self.assertEqual(self.interp.register['R0'], 0xFFFFFFFF)

        with self.assertRaises(iarm.exceptions.IarmError):
            # Can use immediates
            self.interp.evaluate(" LDRSB R0, [R2, #0]")

        with self.assertRaises(iarm.exceptions.IarmError):
            # Can use SP
            self.interp.evaluate(" LDRSB R0, [SP, R1]")

    @unittest.skip('No Test Defined')
    def test_LDRSH(self):
        self.interp.memory[0] = 0xFF
        self.interp.memory[1] = 0x7F
        self.interp.memory[5] = 0x21
        self.interp.register['R1'] = 0
        self.interp.register['R2'] = 1
        self.interp.register['R4'] = 4

        self.interp.evaluate(" LDRSB R0, [R2, R1]")
        self.interp.run()
        self.assertEqual(self.interp.register['R0'], 0x0000007F)

        self.interp.evaluate(" LDRSB R0, [R1, R1]")
        self.interp.run()
        self.assertEqual(self.interp.register['R0'], 0xFFFFFFFF)

        with self.assertRaises(iarm.exceptions.IarmError):
            # Can use immediates
            self.interp.evaluate(" LDRSB R0, [R2, #0]")

        with self.assertRaises(iarm.exceptions.IarmError):
            # Can use SP
            self.interp.evaluate(" LDRSB R0, [SP, R1]")

    @unittest.skip('No Test Defined')
    def test_POP(self):
        pass

    @unittest.skip('No Test Defined')
    def test_PUSH(self):
        pass

    @unittest.skip('No Test Defined')
    def test_STM(self):
        pass

    def test_STR(self):
        self.interp.register['R0'] = 0x12345678
        self.interp.register['R1'] = 0
        self.interp.register['R2'] = 4
        self.interp.register['SP'] = 8

        self.interp.evaluate(" STR R0, [R1, #0]")
        self.interp.run()
        self.assertEqual(self.interp.memory[0], 0x78)
        self.assertEqual(self.interp.memory[1], 0x56)
        self.assertEqual(self.interp.memory[2], 0x34)
        self.assertEqual(self.interp.memory[3], 0x12)

        self.interp.evaluate(" STR R0, [SP, #4]")
        self.interp.run()
        self.assertEqual(self.interp.memory[12], 0x78)
        self.assertEqual(self.interp.memory[13], 0x56)
        self.assertEqual(self.interp.memory[14], 0x34)
        self.assertEqual(self.interp.memory[15], 0x12)

        self.interp.evaluate(" STR R0, [R1, R2]")
        self.interp.run()
        self.assertEqual(self.interp.memory[4], 0x78)
        self.assertEqual(self.interp.memory[5], 0x56)
        self.assertEqual(self.interp.memory[6], 0x34)
        self.assertEqual(self.interp.memory[7], 0x12)

        self.interp.equates['TEST'] = 8
        self.interp.evaluate(" STR R0, [R1, #TEST]")
        self.interp.run()
        self.assertEqual(self.interp.memory[8], 0x78)
        self.assertEqual(self.interp.memory[9], 0x56)
        self.assertEqual(self.interp.memory[10], 0x34)
        self.assertEqual(self.interp.memory[11], 0x12)

    @unittest.skip('No Test Defined')
    def test_STRB(self):
        pass

    @unittest.skip('No Test Defined')
    def test_STRH(self):
        pass

    def test_LDR_SPACE(self):
        # A regression test
        self.interp.evaluate("""
 LDR R1, =P
 LDR R2, =R
P SPACE 4
R SPACE 4
""")
        self.interp.run()
        self.assertEqual(self.interp.register["R1"], 0)
        self.assertEqual(self.interp.register["R2"], 4)

    def test_LDR_SPACE_separate_blocks(self):
        # A regression test
        self.interp.evaluate("""
 LDR R1, =P
 LDR R2, =R""")
        self.interp.evaluate("""
P SPACE 4
R SPACE 4
""")
        self.interp.run()
        self.assertEqual(self.interp.register["R1"], 0)
        self.assertEqual(self.interp.register["R2"], 4)

if __name__ == '__main__':
    unittest.main()
