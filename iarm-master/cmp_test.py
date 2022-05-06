import iarm.arm
interp = iarm.arm.Arm()

interp.evaluate("""
    MVNS R4, R1
    SUBS R4, #10
    MOVS R0, #4
    CMP R4, R0
    BHI 4
    NOOP
    MOVS R7, #7
    MOVS R7, #7
4 MOVS R7, #7
""")

interp.run()
print(interp.register)

