from .test_iarm import TestArm
import iarm.exceptions
import unittest


# TODO make sure to also test no destination registers
class TestArmShift(TestArm):
    @unittest.skip('No Test Defined')
    def test_ASRS(self):
        pass

    @unittest.skip('No Test Defined')
    def test_LSLS(self):
        pass

    @unittest.skip('No Test Defined')
    def test_LSRS(self):
        pass

    @unittest.skip('No Test Defined')
    def test_RORS(self):
        pass

if __name__ == '__main__':
    unittest.main()
