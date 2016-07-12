# Load simulation
vsim work.simple_fib_tb

#                       Group Name            Radix                 Signal(s)
#------------------------------------------------------------------------------

# simple_fib_tb
add wave    -noupdate   -group {tb}           -radix hexadecimal    /simple_fib_tb/*


# update the name of your modules

# processor
add wave    -noupdate   -group {processor}    -radix hexadecimal    /simple_fib_tb/dut/*

# instruction memory
add wave    -noupdate   -group {imem}         -radix hexadecimal    /simple_fib_tb/dut/imem/*

# register file
add wave    -noupdate   -group {rf}           -radix hexadecimal    /simple_fib_tb/dut/rf/*

# alu
add wave    -noupdate   -group {alu}          -radix hexadecimal    /simple_fib_tb/dut/alu_1/*

# data memory
add wave    -noupdate   -group {dmem}         -radix hexadecimal    /simple_fib_tb/dut/dmem/*

# Use short names
configure wave -signalnamewidth 1