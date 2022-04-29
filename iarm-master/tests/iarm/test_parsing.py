from .test_iarm import TestArm
import iarm.exceptions
import unittest


class TestArmParsing(TestArm):
    """
    Test all parsing exceptions
    """
    def test_bad_parameter(self):
        with self.assertRaises(iarm.exceptions.ParsingError):
            self.interp.evaluate(' MOVS R1, 123')

    def test_no_parameters(self):
        with self.assertRaises(iarm.exceptions.ParsingError) as cm:
            self.interp.evaluate(' MOVS')
        self.assertIn('None', str(cm.exception))

    def test_missing_first_parameter(self):
        with self.assertRaises(iarm.exceptions.ParsingError) as cm:
            self.interp.evaluate(' MOVS ,')
        self.assertIn('first', str(cm.exception))

    def test_one_parameters(self):
        with self.assertRaises(iarm.exceptions.ParsingError) as cm:
            self.interp.evaluate(' MOVS R1,')
        self.assertIn('second', str(cm.exception))

    def test_extra_argument(self):
        with self.assertRaises(iarm.exceptions.ParsingError) as cm:
            self.interp.evaluate(' MOVS R1, #123, 456')
        self.assertIn('Extra', str(cm.exception))

    def test_missing_comma(self):
        with self.assertRaises(iarm.exceptions.ParsingError) as cm:
            self.interp.evaluate(' MOVS R1 #123')
        self.assertIn('comma', str(cm.exception))

    def test_unknown_parameter(self):
        with self.assertRaises(iarm.exceptions.ParsingError) as cm:
            self.interp.evaluate(' MOVS abc, 123')
        self.assertIn('Unknown', str(cm.exception))


class TestArmValidation(TestArm):
    """
    Test validation errors
    """
    def test_bad_instruction(self):
        with self.assertRaises(iarm.exceptions.ValidationError):
            self.interp.evaluate(' BADINST')

    def test_bad_formatting(self):
        with self.assertRaises(iarm.exceptions.ValidationError):
            self.interp.evaluate('B .')  # `B .` used to pass because `.` is not letter, had to fix regex

if __name__ == '__main__':
    unittest.main()
