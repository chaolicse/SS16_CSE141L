# ModelSim 10.4b bug: need to delete library if it already exists because
# vlib work will seg fault otherwise.  
if {[file isdirectory work]} {
    vdel -all -lib work
}

# Create library
vlib work

# Compile .v files.
vlog -work work "../../src/processor.v"
vlog -work work "../../src/alu.v"
vlog -work work "../../src/async_memory.v"
vlog -work work "../../src/data_memory.v"
vlog -work work "../../src/inst_rom.v"
vlog -work work "../../src/reg_file.v"
vlog -work work "../../src/serial_buf.v"
vlog -work work "../../src/control_unit.v"
vlog -work work "processor_tb.v" 
