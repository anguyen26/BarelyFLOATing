onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /cpuStim/testCpu/PC
add wave -noupdate -radix decimal -childformat {{{/cpuStim/testCpu/PCNext[15]} -radix decimal} {{/cpuStim/testCpu/PCNext[14]} -radix decimal} {{/cpuStim/testCpu/PCNext[13]} -radix decimal} {{/cpuStim/testCpu/PCNext[12]} -radix decimal} {{/cpuStim/testCpu/PCNext[11]} -radix decimal} {{/cpuStim/testCpu/PCNext[10]} -radix decimal} {{/cpuStim/testCpu/PCNext[9]} -radix decimal} {{/cpuStim/testCpu/PCNext[8]} -radix decimal} {{/cpuStim/testCpu/PCNext[7]} -radix decimal} {{/cpuStim/testCpu/PCNext[6]} -radix decimal} {{/cpuStim/testCpu/PCNext[5]} -radix decimal} {{/cpuStim/testCpu/PCNext[4]} -radix decimal} {{/cpuStim/testCpu/PCNext[3]} -radix decimal} {{/cpuStim/testCpu/PCNext[2]} -radix decimal} {{/cpuStim/testCpu/PCNext[1]} -radix decimal} {{/cpuStim/testCpu/PCNext[0]} -radix decimal}} -subitemconfig {{/cpuStim/testCpu/PCNext[15]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[14]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[13]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[12]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[11]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[10]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[9]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[8]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[7]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[6]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[5]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[4]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[3]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[2]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[1]} {-height 15 -radix decimal} {/cpuStim/testCpu/PCNext[0]} {-height 15 -radix decimal}} /cpuStim/testCpu/PCNext
add wave -noupdate /cpuStim/reset
add wave -noupdate /cpuStim/clk
add wave -noupdate -divider RegFile
add wave -noupdate /cpuStim/testCpu/registers/wr_en
add wave -noupdate -radix decimal /cpuStim/testCpu/registers/wr_data
add wave -noupdate -radix decimal /cpuStim/testCpu/registers/wr_addr
add wave -noupdate -radix decimal /cpuStim/testCpu/registers/rd_data_1
add wave -noupdate -radix decimal /cpuStim/testCpu/registers/rd_data_0
add wave -noupdate -radix decimal /cpuStim/testCpu/registers/rd_addr_1
add wave -noupdate -radix decimal -childformat {{{/cpuStim/testCpu/registers/rd_addr_0[3]} -radix decimal} {{/cpuStim/testCpu/registers/rd_addr_0[2]} -radix decimal} {{/cpuStim/testCpu/registers/rd_addr_0[1]} -radix decimal} {{/cpuStim/testCpu/registers/rd_addr_0[0]} -radix decimal}} -subitemconfig {{/cpuStim/testCpu/registers/rd_addr_0[3]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/rd_addr_0[2]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/rd_addr_0[1]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/rd_addr_0[0]} {-height 15 -radix decimal}} /cpuStim/testCpu/registers/rd_addr_0
add wave -noupdate -radix decimal -childformat {{{/cpuStim/testCpu/registers/MEM[15]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[14]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[13]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[12]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[11]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[10]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[9]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[8]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[7]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[6]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[5]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[4]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[3]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[2]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[1]} -radix decimal} {{/cpuStim/testCpu/registers/MEM[0]} -radix decimal}} -expand -subitemconfig {{/cpuStim/testCpu/registers/MEM[15]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[14]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[13]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[12]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[11]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[10]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[9]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[8]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[7]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[6]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[5]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[4]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[3]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[2]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[1]} {-height 15 -radix decimal} {/cpuStim/testCpu/registers/MEM[0]} {-height 15 -radix decimal}} /cpuStim/testCpu/registers/MEM
add wave -noupdate -radix decimal -childformat {{{/cpuStim/testCpu/reg1Addr[3]} -radix decimal} {{/cpuStim/testCpu/reg1Addr[2]} -radix decimal} {{/cpuStim/testCpu/reg1Addr[1]} -radix decimal} {{/cpuStim/testCpu/reg1Addr[0]} -radix decimal}} -subitemconfig {{/cpuStim/testCpu/reg1Addr[3]} {-height 15 -radix decimal} {/cpuStim/testCpu/reg1Addr[2]} {-height 15 -radix decimal} {/cpuStim/testCpu/reg1Addr[1]} {-height 15 -radix decimal} {/cpuStim/testCpu/reg1Addr[0]} {-height 15 -radix decimal}} /cpuStim/testCpu/reg1Addr
add wave -noupdate -radix decimal /cpuStim/testCpu/reg2Addr
add wave -noupdate -radix decimal -childformat {{{/cpuStim/testCpu/regWriteAddr[3]} -radix decimal} {{/cpuStim/testCpu/regWriteAddr[2]} -radix decimal} {{/cpuStim/testCpu/regWriteAddr[1]} -radix decimal} {{/cpuStim/testCpu/regWriteAddr[0]} -radix decimal}} -subitemconfig {{/cpuStim/testCpu/regWriteAddr[3]} {-height 15 -radix decimal} {/cpuStim/testCpu/regWriteAddr[2]} {-height 15 -radix decimal} {/cpuStim/testCpu/regWriteAddr[1]} {-height 15 -radix decimal} {/cpuStim/testCpu/regWriteAddr[0]} {-height 15 -radix decimal}} /cpuStim/testCpu/regWriteAddr
add wave -noupdate -divider ControlSignals
add wave -noupdate -radix unsigned /cpuStim/testCpu/Reg1Loc
add wave -noupdate -radix unsigned /cpuStim/testCpu/Reg2Loc
add wave -noupdate -radix unsigned -childformat {{{/cpuStim/testCpu/Reg3Loc[1]} -radix unsigned} {{/cpuStim/testCpu/Reg3Loc[0]} -radix unsigned}} -subitemconfig {{/cpuStim/testCpu/Reg3Loc[1]} {-height 15 -radix unsigned} {/cpuStim/testCpu/Reg3Loc[0]} {-height 15 -radix unsigned}} /cpuStim/testCpu/Reg3Loc
add wave -noupdate /cpuStim/testCpu/noop
add wave -noupdate -divider Instr's
add wave -noupdate -radix binary -childformat {{{/cpuStim/testCpu/instr[15]} -radix binary} {{/cpuStim/testCpu/instr[14]} -radix binary} {{/cpuStim/testCpu/instr[13]} -radix binary} {{/cpuStim/testCpu/instr[12]} -radix binary} {{/cpuStim/testCpu/instr[11]} -radix binary} {{/cpuStim/testCpu/instr[10]} -radix binary} {{/cpuStim/testCpu/instr[9]} -radix binary} {{/cpuStim/testCpu/instr[8]} -radix binary} {{/cpuStim/testCpu/instr[7]} -radix binary} {{/cpuStim/testCpu/instr[6]} -radix binary} {{/cpuStim/testCpu/instr[5]} -radix binary} {{/cpuStim/testCpu/instr[4]} -radix binary} {{/cpuStim/testCpu/instr[3]} -radix binary} {{/cpuStim/testCpu/instr[2]} -radix binary} {{/cpuStim/testCpu/instr[1]} -radix binary} {{/cpuStim/testCpu/instr[0]} -radix binary}} -subitemconfig {{/cpuStim/testCpu/instr[15]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[14]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[13]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[12]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[11]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[10]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[9]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[8]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[7]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[6]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[5]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[4]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[3]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[2]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[1]} {-height 15 -radix binary} {/cpuStim/testCpu/instr[0]} {-height 15 -radix binary}} /cpuStim/testCpu/instr
add wave -noupdate -radix binary -childformat {{{/cpuStim/testCpu/RFinstr[15]} -radix binary} {{/cpuStim/testCpu/RFinstr[14]} -radix binary} {{/cpuStim/testCpu/RFinstr[13]} -radix binary} {{/cpuStim/testCpu/RFinstr[12]} -radix binary} {{/cpuStim/testCpu/RFinstr[11]} -radix binary} {{/cpuStim/testCpu/RFinstr[10]} -radix binary} {{/cpuStim/testCpu/RFinstr[9]} -radix binary} {{/cpuStim/testCpu/RFinstr[8]} -radix binary} {{/cpuStim/testCpu/RFinstr[7]} -radix binary} {{/cpuStim/testCpu/RFinstr[6]} -radix binary} {{/cpuStim/testCpu/RFinstr[5]} -radix binary} {{/cpuStim/testCpu/RFinstr[4]} -radix binary} {{/cpuStim/testCpu/RFinstr[3]} -radix binary} {{/cpuStim/testCpu/RFinstr[2]} -radix binary} {{/cpuStim/testCpu/RFinstr[1]} -radix binary} {{/cpuStim/testCpu/RFinstr[0]} -radix binary}} -subitemconfig {{/cpuStim/testCpu/RFinstr[15]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[14]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[13]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[12]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[11]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[10]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[9]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[8]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[7]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[6]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[5]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[4]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[3]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[2]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[1]} {-height 15 -radix binary} {/cpuStim/testCpu/RFinstr[0]} {-height 15 -radix binary}} /cpuStim/testCpu/RFinstr
add wave -noupdate -radix binary /cpuStim/testCpu/EXinstr
add wave -noupdate -divider Branching/PC
add wave -noupdate -radix unsigned /cpuStim/testCpu/brSel
add wave -noupdate -radix decimal /cpuStim/testCpu/branchAddr
add wave -noupdate /cpuStim/testCpu/pcOffset
add wave -noupdate /cpuStim/testCpu/brancherAdder/cout
add wave -noupdate /cpuStim/testCpu/brancherAdder/in1
add wave -noupdate /cpuStim/testCpu/brancherAdder/in2
add wave -noupdate /cpuStim/testCpu/brancherAdder/middleCarryOuts
add wave -noupdate /cpuStim/testCpu/brancherAdder/N
add wave -noupdate /cpuStim/testCpu/brancherAdder/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {74459 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {215250 ps}
