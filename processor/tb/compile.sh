# entities
ghdl -a ../../mux/mux4x1.vhd
ghdl -e mux4x1

ghdl -a ../../alu/alu.vhd
ghdl -e alu

ghdl -a ../../mux/mux2x1.vhd
ghdl -e mux2x1

ghdl -a ../../register/register16.vhd
ghdl -e register16

ghdl -a ../../reg_bank/reg_bank_8x16.vhd
ghdl -e reg_bank_8x16

ghdl -a ../../pc/pc_7.vhd
ghdl -e pc_7

ghdl -a ../../state_mach/state_mach_3.vhd
ghdl -e state_mach_3

ghdl -a ../../register/register17.vhd
ghdl -e register17

ghdl -a ../../rom/rom_128x17.vhd
ghdl -e rom_128x17

ghdl -a ../../control_unit/control_unit.vhd
ghdl -e control_unit

ghdl -a ../../register/register17.vhd
ghdl -e register17

ghdl -a ../processor.vhd
ghdl -e processor

# testbench
#ghdl -a processor_tb.vhd
#ghdl -e processor_tb

# run and view
#ghdl -r processor_tb --wave=compiled/processor_tb.ghw
#gtkwave compiled/processor_tb.ghw
