# Load simulation
vsim work.processor_tb

#                       Group Name            Radix                 Signal(s)
#------------------------------------------------------------------------------

# processor_tb
add wave    -noupdate   -group {tb}           -radix hexadecimal    /processor_tb/*


# update the name of your modules

# processor
add wave    -noupdate   -group {processor}    -radix hexadecimal    /processor_tb/dut/*

# instruction memory
add wave    -noupdate   -group {imem}         -radix hexadecimal    /processor_tb/dut/imem/*

# register file
add wave    -noupdate   -group {rf}           -radix hexadecimal    /processor_tb/dut/rf/*

# alu
add wave    -noupdate   -group {alu}          -radix hexadecimal    /processor_tb/dut/alu_1/*

# data memory
add wave    -noupdate   -group {dmem}         -radix hexadecimal    /processor_tb/dut/dmem/*

# Use short names
configure wave -signalnamewidth 1