# This runs all instructions in assembly_instr.txt
# (or b_assembly_instr.txt if you uncomment line 7)

import iarm.arm
interp = iarm.arm.Arm()

# with open("/b_assembly_instr.txt", "r") as f:
# with open("each_assembly_instr.txt", "r") as f:
# with open("benchmarks/test01_MovAddSub.txt", "r") as f:
# with open("tests/random.txt", "r") as f:
with open("assembler/ackermann.arm", "r") as f:
    instrs = f.read()
# print(instrs)
interp.evaluate(instrs)
interp.run()
print(interp.register)
print(interp.memory)
