# Begin_DVE_Session_Save_Info
# DVE reload session
# Saved on Fri May 27 16:00:49 2022
# Designs open: 1
#   V1: /home/nguyea9/ee478/Core/vcdplus.vpd
# Toplevel windows open: 2
# 	TopLevel.2
# 	TopLevel.3
#   Wave.1: 112 signals
#   Group count = 15
#   Group cpuControl_testbench signal count = 0
#   Group cpuStim_1 signal count = 5
#   Group registers signal count = 1
#   Group controlUnit signal count = 1
#   Group aluBlock signal count = 9
#   Group Regfile signal count = 9
#   Group Top Level signal count = 20
#   Group FPU signal count = 15
#   Group Control signal count = 21
#   Group ALU signal count = 9
#   Group FlagsLatch signal count = 5
#   Group Group1 signal count = 26
#   Group instructionMemory signal count = 8
# End_DVE_Session_Save_Info

# DVE version: S-2021.09-SP1_Full64
# DVE build date: Nov 30 2021 00:09:19


#<Session mode="Reload" path="/home/nguyea9/ee478/Core/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Reload
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all
gui_clear_window -type Wave
gui_clear_window -type List

# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.2

set TopLevel.2 TopLevel.2

# Docked window settings
gui_sync_global -id ${TopLevel.2} -option true

# MDI window settings
set Wave.1 Wave.1
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 843} {child_wave_right 671} {child_wave_colname 395} {child_wave_colvalue 444} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


# Create and position top-level window: TopLevel.3

set TopLevel.3 TopLevel.3

# Docked window settings
set HSPane.1 HSPane.1
set Hier.1 Hier.1
set Console.1 Console.1
gui_sync_global -id ${TopLevel.3} -option true

# MDI window settings
set DLPane.1 DLPane.1
set Data.1 Data.1
gui_update_layout -id ${DLPane.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_data_colvariable 194} {child_data_colvalue 48} {child_data_coltype 104} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}

# End MDI window settings


#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {/home/nguyea9/ee478/Core/vcdplus.vpd}] } {
	gui_open_db -design V1 -file /home/nguyea9/ee478/Core/vcdplus.vpd -nosource
}
gui_set_precision 1ps
gui_set_time_units 1ps
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions
gui_expr_create {(result[6]*0.5)+(result[5]*0.25)+(result[4]*0.125)+(result[3]*0.0625)+(result[2]*0.03125)+(result[1]*0.015625)+(result[0]*0.0078125)+1}  -name EXP:mantR -type Verilog -scope cpuStim.testCpu.FPU
gui_expr_create {(opA[6]*0.5)+(opA[5]*0.25)+(opA[4]*0.125)+(opA[3]*0.0625)+(opA[2]*0.03125)+(opA[1]*0.015625)+(opA[0]*0.0078125)+1}  -name EXP:mantA -type Verilog -scope cpuStim.testCpu.FPU
gui_expr_create {(opB[6]*0.5)+(opB[5]*0.25)+(opB[4]*0.125)+(opB[3]*0.0625)+(opB[2]*0.03125)+(opB[1]*0.015625)+(opB[0]*0.0078125)+1}  -name EXP:mantB -type Verilog -scope cpuStim.testCpu.FPU
gui_expr_create {((opA[6]*0.5)+(opA[5]*0.25)+(opA[4]*0.125)+(opA[3]*0.0625)+(opA[2]*0.03125)+(opA[1]*0.015625)+(opA[0]*0.0078125))*10}  -name EXP:A -type Verilog -scope cpuStim.testCpu.FPU
gui_expr_create {result[14:7]-127}  -name EXP:eR -type Verilog -scope cpuStim.testCpu.FPU
gui_expr_create {opA[14:7]-127}  -name EXP:expA -type Verilog -scope cpuStim.testCpu.FPU
gui_expr_create {opB[14:7]-127}  -name EXP:expB -type Verilog -scope cpuStim.testCpu.FPU
gui_expr_create {result[14:7]-127}  -name EXP:expR -type Verilog -scope cpuStim.testCpu.FPU
gui_expr_create {PC[15:0]/4+1}  -name EXP:LineNum -type Verilog -scope cpuStim.testCpu

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {cpuStim.testCpu}
gui_load_child_values {cpuStim.testCpu.instructionMemory}
gui_load_child_values {cpuStim.testCpu.controlUnit}
gui_load_child_values {cpuStim.testCpu.FPU}
gui_load_child_values {cpuStim.testCpu.aluBlock}
gui_load_child_values {cpuStim.testCpu.registers}
gui_load_child_values {cpuStim.testCpu.FlagsLatch}


set _session_group_254 cpuControl_testbench
gui_sg_create "$_session_group_254"
set cpuControl_testbench "$_session_group_254"


set _session_group_255 cpuStim_1
gui_sg_create "$_session_group_255"
set cpuStim_1 "$_session_group_255"

gui_sg_addsignal -group "$_session_group_255" { cpuStim.testCpu.clk cpuStim.testCpu.reset cpuStim.testCpu.PC cpuStim.testCpu.PCNext cpuStim.testCpu.instr }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instr}

set _session_group_256 registers
gui_sg_create "$_session_group_256"
set registers "$_session_group_256"

gui_sg_addsignal -group "$_session_group_256" { }

set _session_group_257 $_session_group_256|
append _session_group_257 registers
gui_sg_create "$_session_group_257"
set registers|registers "$_session_group_257"

gui_sg_addsignal -group "$_session_group_257" { cpuStim.testCpu.registers.MEM cpuStim.testCpu.registers.wr_en cpuStim.testCpu.registers.wr_data cpuStim.testCpu.registers.wr_addr cpuStim.testCpu.registers.rd_addr_0 cpuStim.testCpu.registers.rd_addr_1 cpuStim.testCpu.registers.rd_data_0 cpuStim.testCpu.registers.rd_data_1 }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.MEM}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.MEM}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.wr_data}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.wr_data}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.rd_addr_0}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_addr_0}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.rd_addr_1}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_addr_1}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.rd_data_0}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_data_0}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.rd_data_1}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_data_1}

set _session_group_258 controlUnit
gui_sg_create "$_session_group_258"
set controlUnit "$_session_group_258"

gui_sg_addsignal -group "$_session_group_258" { }

set _session_group_259 $_session_group_258|
append _session_group_259 controlUnit
gui_sg_create "$_session_group_259"
set controlUnit|controlUnit "$_session_group_259"

gui_sg_addsignal -group "$_session_group_259" { cpuStim.testCpu.controlUnit.PC cpuStim.testCpu.controlUnit.instr cpuStim.testCpu.controlUnit.FlagsReg cpuStim.testCpu.controlUnit.clk cpuStim.testCpu.controlUnit.reset cpuStim.testCpu.controlUnit.RegWrite cpuStim.testCpu.controlUnit.MemWrite cpuStim.testCpu.controlUnit.MemRead cpuStim.testCpu.controlUnit.ShiftDir cpuStim.testCpu.controlUnit.keepFlags cpuStim.testCpu.controlUnit.Reg1Loc cpuStim.testCpu.controlUnit.Reg2Loc cpuStim.testCpu.controlUnit.Reg3Loc cpuStim.testCpu.controlUnit.selOpB cpuStim.testCpu.controlUnit.selOpA cpuStim.testCpu.controlUnit.ALUOp cpuStim.testCpu.controlUnit.brSel cpuStim.testCpu.controlUnit.brEx cpuStim.testCpu.controlUnit.selWrData cpuStim.testCpu.controlUnit.opcode }

set _session_group_260 aluBlock
gui_sg_create "$_session_group_260"
set aluBlock "$_session_group_260"

gui_sg_addsignal -group "$_session_group_260" { cpuStim.testCpu.aluBlock.ALUFlags cpuStim.testCpu.aluBlock.Result cpuStim.testCpu.aluBlock.adder_out cpuStim.testCpu.aluBlock.temp_op cpuStim.testCpu.aluBlock.a cpuStim.testCpu.aluBlock.b cpuStim.testCpu.aluBlock.SIZE cpuStim.testCpu.aluBlock.ALUControl cpuStim.testCpu.aluBlock.carry }
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.aluBlock.Result}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.aluBlock.Result}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.aluBlock.a}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.aluBlock.a}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.aluBlock.b}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.aluBlock.b}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}

set _session_group_261 Regfile
gui_sg_create "$_session_group_261"
set Regfile "$_session_group_261"

gui_sg_addsignal -group "$_session_group_261" { cpuStim.testCpu.ALUorFPUE cpuStim.testCpu.registers.MEM cpuStim.testCpu.registers.rd_addr_0 cpuStim.testCpu.registers.rd_addr_1 cpuStim.testCpu.registers.wr_addr cpuStim.testCpu.registers.wr_en cpuStim.testCpu.registers.wr_data cpuStim.testCpu.registers.rd_data_0 cpuStim.testCpu.registers.rd_data_1 }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.MEM}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.MEM}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.rd_addr_0}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_addr_0}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.rd_addr_1}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_addr_1}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.wr_data}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.wr_data}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.rd_data_0}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_data_0}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.rd_data_1}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_data_1}

set _session_group_262 {Top Level}
gui_sg_create "$_session_group_262"
set {Top Level} "$_session_group_262"

gui_sg_addsignal -group "$_session_group_262" { cpuStim.testCpu.clk cpuStim.testCpu.reset cpuStim.testCpu.PC EXP:LineNum cpuStim.testCpu.PCNext cpuStim.testCpu.PCE cpuStim.testCpu.PCNext_preStall cpuStim.testCpu.PCPlus1 cpuStim.testCpu.instr cpuStim.testCpu.instrE cpuStim.testCpu.stallF cpuStim.testCpu.controlUnit.ALUorFPU cpuStim.testCpu.Forward1 cpuStim.testCpu.opAE cpuStim.testCpu.regWrData cpuStim.testCpu.Forward2 cpuStim.testCpu.ReadData2E cpuStim.testCpu.selOpB cpuStim.testCpu.selOpBE cpuStim.testCpu.opBE }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {decimal} -signals {EXP:LineNum}
gui_set_radix -radix {unsigned} -signals {EXP:LineNum}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCE}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCE}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCNext_preStall}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCNext_preStall}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCPlus1}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCPlus1}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instrE}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instrE}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.opAE}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.opAE}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.regWrData}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.regWrData}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.ReadData2E}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.ReadData2E}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.opBE}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.opBE}

set _session_group_263 FPU
gui_sg_create "$_session_group_263"
set FPU "$_session_group_263"

gui_sg_addsignal -group "$_session_group_263" { cpuStim.testCpu.FPU.opA cpuStim.testCpu.FPU.opB EXP:mantA EXP:mantB EXP:expA EXP:expB }
gui_sg_addsignal -group "$_session_group_263" { Divider } -divider
gui_sg_addsignal -group "$_session_group_263" { cpuStim.testCpu.FPU.result EXP:mantR EXP:expR cpuStim.testCpu.FPU.op cpuStim.testCpu.FPU.overflow cpuStim.testCpu.FPU.underflow cpuStim.testCpu.FPU.inexact cpuStim.testCpu.FPU.FPUFlags }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.FPU.opA}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.FPU.opA}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.FPU.opB}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.FPU.opB}
gui_set_radix -radix {decimal} -signals {EXP:expA}
gui_set_radix -radix {twosComplement} -signals {EXP:expA}
gui_set_radix -radix {decimal} -signals {EXP:expB}
gui_set_radix -radix {twosComplement} -signals {EXP:expB}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.FPU.result}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.FPU.result}
gui_set_radix -radix {decimal} -signals {EXP:expR}
gui_set_radix -radix {twosComplement} -signals {EXP:expR}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.FPU.FPUFlags}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.FPU.FPUFlags}

set _session_group_264 Control
gui_sg_create "$_session_group_264"
set Control "$_session_group_264"

gui_sg_addsignal -group "$_session_group_264" { cpuStim.testCpu.controlUnit.Reg1Loc cpuStim.testCpu.controlUnit.PC cpuStim.testCpu.controlUnit.brEx cpuStim.testCpu.controlUnit.Reg2Loc cpuStim.testCpu.controlUnit.ALUOp cpuStim.testCpu.controlUnit.FPUOp cpuStim.testCpu.controlUnit.Reg3Loc cpuStim.testCpu.controlUnit.selOpA cpuStim.testCpu.controlUnit.MemRead cpuStim.testCpu.controlUnit.reset cpuStim.testCpu.controlUnit.selOpB cpuStim.testCpu.controlUnit.FlagsReg cpuStim.testCpu.controlUnit.selWrData cpuStim.testCpu.controlUnit.instr cpuStim.testCpu.controlUnit.brSel cpuStim.testCpu.controlUnit.keepFlags cpuStim.testCpu.controlUnit.MemWrite cpuStim.testCpu.controlUnit.ShiftDir cpuStim.testCpu.controlUnit.clk cpuStim.testCpu.controlUnit.RegWrite cpuStim.testCpu.controlUnit.opcode }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.FPUOp}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.FPUOp}

set _session_group_265 ALU
gui_sg_create "$_session_group_265"
set ALU "$_session_group_265"

gui_sg_addsignal -group "$_session_group_265" { cpuStim.testCpu.aluBlock.ALUFlags cpuStim.testCpu.aluBlock.Result cpuStim.testCpu.aluBlock.adder_out cpuStim.testCpu.aluBlock.temp_op cpuStim.testCpu.aluBlock.a cpuStim.testCpu.aluBlock.b cpuStim.testCpu.aluBlock.SIZE cpuStim.testCpu.aluBlock.ALUControl cpuStim.testCpu.aluBlock.carry }
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.aluBlock.Result}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.aluBlock.Result}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.aluBlock.a}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.aluBlock.a}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.aluBlock.b}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.aluBlock.b}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}

set _session_group_266 FlagsLatch
gui_sg_create "$_session_group_266"
set FlagsLatch "$_session_group_266"

gui_sg_addsignal -group "$_session_group_266" { cpuStim.testCpu.FlagsLatch.IN cpuStim.testCpu.FlagsLatch.EN cpuStim.testCpu.FlagsLatch.RST cpuStim.testCpu.FlagsLatch.OUT cpuStim.testCpu.FlagsLatch.i }
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.FlagsLatch.EN}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.FlagsLatch.EN}

set _session_group_267 Group1
gui_sg_create "$_session_group_267"
set Group1 "$_session_group_267"

gui_sg_addsignal -group "$_session_group_267" { {cpuStim.testCpu.instructionMemory.mem[34]} {cpuStim.testCpu.instructionMemory.mem[33]} {cpuStim.testCpu.instructionMemory.mem[32]} {cpuStim.testCpu.instructionMemory.mem[31]} {cpuStim.testCpu.instructionMemory.mem[30]} {cpuStim.testCpu.instructionMemory.mem[29]} {cpuStim.testCpu.instructionMemory.mem[28]} {cpuStim.testCpu.instructionMemory.mem[27]} {cpuStim.testCpu.instructionMemory.mem[26]} {cpuStim.testCpu.instructionMemory.mem[25]} {cpuStim.testCpu.instructionMemory.mem[24]} {cpuStim.testCpu.instructionMemory.mem[23]} {cpuStim.testCpu.instructionMemory.mem[22]} {cpuStim.testCpu.instructionMemory.mem[12]} {cpuStim.testCpu.instructionMemory.mem[11]} {cpuStim.testCpu.instructionMemory.mem[10]} {cpuStim.testCpu.instructionMemory.mem[9]} {cpuStim.testCpu.instructionMemory.mem[8]} {cpuStim.testCpu.instructionMemory.mem[7]} {cpuStim.testCpu.instructionMemory.mem[6]} {cpuStim.testCpu.instructionMemory.mem[5]} {cpuStim.testCpu.instructionMemory.mem[4]} {cpuStim.testCpu.instructionMemory.mem[3]} {cpuStim.testCpu.instructionMemory.mem[2]} {cpuStim.testCpu.instructionMemory.mem[1]} {cpuStim.testCpu.instructionMemory.mem[0]} }

set _session_group_268 instructionMemory
gui_sg_create "$_session_group_268"
set instructionMemory "$_session_group_268"

gui_sg_addsignal -group "$_session_group_268" { cpuStim.testCpu.instructionMemory.address cpuStim.testCpu.instructionMemory.clk cpuStim.testCpu.instructionMemory.i cpuStim.testCpu.instructionMemory.instruction cpuStim.testCpu.instructionMemory.mem {cpuStim.testCpu.instructionMemory.unnamed$$_0} {cpuStim.testCpu.instructionMemory.unnamed$$_1} {cpuStim.testCpu.instructionMemory.unnamed$$_2} }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.instructionMemory.address}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instructionMemory.address}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instructionMemory.instruction}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instructionMemory.instruction}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 375000



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_wv_zoom_timerange -id ${Wave.1} 187473 379973
gui_list_add_group -id ${Wave.1} -after {New Group} {{Top Level}}
gui_list_add_group -id ${Wave.1} -after {New Group} {FPU}
gui_list_add_group -id ${Wave.1} -after {New Group} {Regfile}
gui_list_add_group -id ${Wave.1} -after {New Group} {Control}
gui_list_add_group -id ${Wave.1} -after {New Group} {ALU}
gui_list_add_group -id ${Wave.1} -after {New Group} {FlagsLatch}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group1}
gui_list_add_group -id ${Wave.1} -after {New Group} {instructionMemory}
gui_list_collapse -id ${Wave.1} FPU
gui_list_collapse -id ${Wave.1} Control
gui_list_expand -id ${Wave.1} cpuStim.testCpu.instructionMemory.mem
gui_list_select -id ${Wave.1} {{cpuStim.testCpu.instructionMemory.mem[58]} }
gui_seek_criteria -id ${Wave.1} {Any Edge}



gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.1}
gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group instructionMemory  -position in

gui_marker_move -id ${Wave.1} {C1} 375000
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false

# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*} -force
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} cpuStim}
catch {gui_list_expand -id ${Hier.1} cpuStim.testCpu}
catch {gui_list_select -id ${Hier.1} {cpuStim.testCpu.instructionMemory}}
gui_view_scroll -id ${Hier.1} -vertical -set 500
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {cpuStim.testCpu.instructionMemory}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 500
gui_view_scroll -id ${Hier.1} -horizontal -set 0
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
if {[gui_exist_window -window ${TopLevel.3}]} {
	gui_set_active_window -window ${TopLevel.3}
	gui_set_active_window -window ${DLPane.1}
	gui_set_active_window -window ${HSPane.1}
}
#</Session>

