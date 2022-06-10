# 16b ARM Microprocessor
#### _With Floating Point Unit_
&nbsp;
## Project Description
This project impliments a 16-bit CPU that runs a reduced list of the ARM instruction set which is detailed below.\
It also impliments a 16-bit Floating Point Unit (FPU) utilizing the Bfloat16 single presicion format.\
Additionally there is a makefile flow for performing SAPR with Synopsis DC and ICC in the TSMC N65 technology.\
Finally there is a verifiction flow for testing each type of test (below) at each stage of design (RTL, SYN, SAPR) \
and verify against the expected results.
- Full list of instructions implimented in core [here](https://github.com/anguyen26/BarelyFLOATing/blob/main/Resources/CustomThumbInstructions.pdf)
- Bfloat16 format [Documentation](https://en.wikipedia.org/wiki/Bfloat16_floating-point_format)

#### File Structure
- src/ : Source files for design & Testing
    - verilog/ : RTL Files and Testbenchs (System Verilog)
    - syn/ : Scripts for generating synthesized design (tcl)
    - assembler/ : Assembly to binary conversion script & Assembly tests (python / asm)
    - apr/ : Scripts for generating layout (tcl)
- sim/ : Folders for running VCS simulations on design & writing waveforms
- sapr/ : Scripts to generate and write output of SAPR files (makefile)
- Resources/ : Project files and doccumentation
- Archive/ : FPU testing & verification flow

#### Running Tests
- RTL
    - Run 'make' in the pre-syn folder to run the sqrt(x) algorithm test 5 times with random x inputs. 
        - To change the number of tests, use NUM_TESTS=x
    - The currently implimented tests are as follows:
        - sqrt
        - log2
        - random (limited functionality)
    - To run a specifc test and automatically compare its result you need to edit the Makefile `$TEST` variable\
    in the respective sim folder then run the following command at the top level:
    
        `make vcs`
- Synthesized
    - Run 'make' in the post-syn folder to run the sqrt(x) algorithm test 5 times with random x inputs. 
        - To change the number of tests, use NUM_TESTS=x
    - The currently implimented tests are as follows:
        - sqrt
        - log2
    - To run a specifc test and automatically compare its result you need to edit the Makefile `$TEST` variable\
    in the respective sim folder then run the following command at the top level:
    
        `make vcs_syn` 
- Layout
    - Run 'make' in the post-apr folder to run the sqrt(x) algorithm test 5 times with random x inputs. 
        - To change the number of tests, use NUM_TESTS=x
    - The currently implimented tests are as follows:
        - sqrt
        - log2
    - To run a specifc test and automatically compare its result you need to edit the Makefile `$TEST` variable\
    in the respective sim folder then run the following command at the top level:
    
        `make vcs_apr`

#### Running SAPR
- Synthesis
    - At the top level of the project run

        `make syn`
    - Resulting design files will be in `sapr/syn/results/`
- APR
    - At the top level of the project run (only once you have a syn design file in `sapr/syn/`)
    
        `make apr`
    - Resulting design files will be in `sapr/apr/results/`
