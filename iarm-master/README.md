IArm
====

IArm is an ARM interpreter for the ARMv6 THUMB instruction set
(More specifically for the ARM Cortex M0+ CPU).
It supports almost 100% of the instructions,
and some assembler directives.
There is also its [Jupyter](http://jupyter.org/)
kernel counterpart so it can be
used with Jupyter notebooks.
Check out the `/docs` folder to see a technical overview
and some example notebooks.



Install
-------
IArm is a Python 3 only application.
Use the Py3 versions as needed (`pip3` and `python3`).

Install with pip
```
pip install iarm
```
Or clone the repo and install with setuptools
```
python setup.py install
```

To install the Jupyer kernel counterpart, after installation, run
```
python -m iarm_kernel.install
```



Usage
-----

### Python
Import the `arm` module
and instantiate an interpreter from the `Arm` class
```
import iarm.arm
interp = iarm.arm.Arm()
```
To run code, pass the code into the `evaluate` method.
Multiple lines can be sent in as well as one line at a time.
```
interp.evaluate(" MOVS R0, #5")
interp.evaluate("""
    MOVS R1, #3
    ADDS R2, R0, R1
""")
```
By default, code is not run.
The `run` method must be called.
```
interp.run()
print(interp.register)  # Print out the status of all the registers
```

### Jupyter
Simply activate the iarm_kernel module
and make a new notebook as an `IArm` notebook.
Most of the magics have a 1 to 1 to the module.
Refer to the notebooks in the `/docs/examples` folder
and the `%help` magic.
