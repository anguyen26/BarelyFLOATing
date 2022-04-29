import iarm.arm
interp = iarm.arm.Arm()

interp.evaluate("""
    MOVS R1, #255
    ADDS R1, R1, R1
    ADDS R1, R1, R1
    ADDS R1, R1, R1
    ADDS R1, R1, R1
    ADDS R1, R1, R1
    ADDS R1, R1, R1
    LDR R2, [R1, #4]
""")

interp.run()
print(interp.register)

