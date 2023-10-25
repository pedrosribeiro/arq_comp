# entities
ghdl -a ../../state_mach/state_mach_3.vhd
ghdl -e state_mach_3

ghdl -a ../control_unit.vhd
ghdl -e control_unit

# testbench
ghdl -a control_unit_tb.vhd
ghdl -e control_unit_tb

# run and view
ghdl -r control_unit_tb --wave=compiled/control_unit_tb.ghw
gtkwave compiled/control_unit_tb.ghw