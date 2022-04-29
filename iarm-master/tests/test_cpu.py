import unittest
import iarm.cpu


class TestCpu(unittest.TestCase):
    pass


class TestRandomValueDict(unittest.TestCase):
    def setUp(self):
        self.register = iarm.cpu.RandomValueDict(8, False)

    def test_link(self):
        self.register['a'] = 0
        self.register['b'] = 1

        self.assertNotEqual(self.register['a'], self.register['b'])

        self.register.link('a', 'b')

        self.assertNotEqual(self.register['a'], self.register['b'])

        self.register['a'] = 5

        self.assertEqual(self.register['a'], self.register['b'])

        self.register['b'] = 6

        self.assertEqual(self.register['a'], self.register['b'])

    @unittest.expectedFailure
    def test_link_transitive(self):
        """
        If 'a' is linked to 'b', and 'b' is linked to 'c', does modifying 'a' change 'c'
        :return:
        """
        self.register['a'] = 0
        self.register['b'] = 0
        self.register['c'] = 0
        self.register.link('a', 'b')
        self.register.link('b', 'c')

        self.register['a'] = 1

        self.assertEqual(self.register['a'], self.register['c'])

        self.register['c'] = 2

        self.assertEqual(self.register['a'], self.register['c'])

        self.register['b'] = 3

        self.assertEqual(self.register['b'], self.register['c'])
        self.assertEqual(self.register['b'], self.register['a'])

    def test_overflow(self):
        self.register['a'] = 255
        self.assertEqual(self.register['a'], 255)
        self.register['a'] += 1
        self.assertEqual(self.register['a'], 0)

if __name__ == '__main__':
    unittest.main()
