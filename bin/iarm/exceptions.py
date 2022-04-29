
class IarmError(Exception):
    pass


class IarmWarning(Warning):
    pass


class RuleError(IarmError):
    pass


class ParsingError(IarmError):
    pass


class ValidationError(IarmError):
    pass


class NotImplementedError(IarmError):
    pass


class BrainFart(IarmError):
    """
    Errors internal to the program or for those 3AM programming mistakes
    """
    pass


class LabelDoesNotExist(IarmWarning):
    """
    Used when a label does not currently exist (but may in the future during execution)
    """
    pass


class EndOfProgram(IarmError):
    """
    When we have reached the end of the program or a known infinite loop
    """


class NotImplementedWarning(IarmWarning):
    """
    Used for instructions or directives that are not yet implemented,
    but do not cause any significant change to the system or
    are irrelevant in an interpreted environment
    """


class HardFault(IarmError):
    """
    Used for cases where the program has validated, is running, and an error or exception occurs
    """
