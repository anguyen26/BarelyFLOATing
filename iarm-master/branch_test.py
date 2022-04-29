import iarm.arm
interp = iarm.arm.Arm()

interp.evaluate("""
    MOVS R1, #3
    ADDS R2, R0, R1
    B 2
    MOVS R3, #4
2 MOVS R4, #4
    MOVS R5, #8
""")

interp.run()
print(interp.register)

