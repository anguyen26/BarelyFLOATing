import iarm.exceptions
from ._meta import _Meta


class Misc(_Meta):
    def BKPT(self):
        raise iarm.exceptions.NotImplementedError

    def CPSID(self):
        raise iarm.exceptions.NotImplementedError

    def CPSIE(self):
        raise iarm.exceptions.NotImplementedError

    def CMB(self):
        raise iarm.exceptions.NotImplementedError

    def DSB(self):
        raise iarm.exceptions.NotImplementedError

    def ISB(self):
        raise iarm.exceptions.NotImplementedError

    def SEV(self):
        raise iarm.exceptions.NotImplementedError

    def SVC(self):
        raise iarm.exceptions.NotImplementedError

    def WFE(self):
        raise iarm.exceptions.NotImplementedError

    def WFI(self):
        raise iarm.exceptions.NotImplementedError
