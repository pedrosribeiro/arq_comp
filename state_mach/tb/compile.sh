ghdl -a ../state_mach_2.vhd
ghdl -e state_mach_2

ghdl -a state_mach_2_tb.vhd
ghdl -e state_mach_2_tb

ghdl -r state_mach_2_tb --wave=compiled/state_mach_2_tb.ghw
gtkwave compiled/state_mach_2_tb.ghw