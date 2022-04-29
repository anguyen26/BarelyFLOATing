from .test_iarm import TestArm
import iarm.exceptions
import unittest


# TODO make sure to also test no destination registers
class TestArmLogic(TestArm):
    @unittest.skip('No Test Defined')
    def test_ANDS(self):
        # TODO write a test
        pass

    @unittest.skip('No Test Defined')
    def test_BICS(self):
        # TODO write a test
        pass

    @unittest.skip('No Test Defined')
    def test_EORS(self):
        # TODO write a test
        pass

    @unittest.skip('No Test Defined')
    def test_ORRS(self):
        # TODO write a test
        pass

    @unittest.skip('No Test Defined')
    def test_TST(self):
        # TODO write a test
        pass

if __name__ == '__main__':
    unittest.main()
