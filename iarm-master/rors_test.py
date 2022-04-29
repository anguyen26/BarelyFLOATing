import iarm.arm
interp = iarm.arm.Arm()

interp.evaluate("""
    MOVS R0, #2
    MOVS R1, #7
    RORS R1, R0
""")

interp.run()
print(interp.register)

