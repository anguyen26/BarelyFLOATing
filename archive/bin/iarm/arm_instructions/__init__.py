"""
This folder contains the ARM v7 thumb intructions

Each file holds one one type of instructions,
broken out for maintainability
"""

from .data_movement import DataMovement
from .arithmetic import Arithmetic
from .logic import Logic
from .shift import Shift
from .memory import Memory
from .conditional_branch import ConditionalBranch
from .unconditional_branch import UnconditionalBranch
from .misc import Misc
from .directives import Directives
