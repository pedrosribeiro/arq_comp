library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity;

architecture a_control_unit_tb of control_unit_tb is
    component control_unit
        port (
            clk             : in std_logic;
            rst             : in std_logic;
            instruction     : in unsigned(16 downto 0); -- rom instruction
            wr_en_pc        : out std_logic;            -- program counter write enable
            wr_en_inst_reg  : out std_logic;            -- instruction register write enable
            alu_src         : out std_logic;
            reg_write       : out std_logic;            -- register bank write enable
            jump_en         : out std_logic;
            alu_op          : out unsigned(1 downto 0)
        );
    end component;

    signal instruction: unsigned(16 downto 0);
    signal wr_en_pc, wr_en_inst_reg, alu_src, reg_write, jump_en: std_logic;
    signal alu_op: unsigned(1 downto 0);

    -- clk and rst waves
    constant period_time    : time := 100 ns;
    signal finished         : std_logic := '0';

    signal clk, rst : std_logic;
begin
    -- instance
    uut: control_unit port map (
        clk             => clk,
        rst             => rst,
        instruction     => instruction,
        wr_en_pc        => wr_en_pc,
        wr_en_inst_reg  => wr_en_inst_reg,
        alu_src         => alu_src,
        reg_write       => reg_write,
        jump_en         => jump_en,
        alu_op          => alu_op
    );

    -- rst global process
    rst_global: process
    begin	
        rst <= '1';
        wait for period_time * 2;
        rst <= '0';
        wait;
    end process;

    -- simulation duration time
    sim_time_process: process
	begin 
		wait for 10 us;
		finished <= '1';
		wait;
	end process;

    -- clk process
    clk_process: process
	begin 
		while finished /= '1' loop
			clk <= '0';
			wait for period_time/2;
			clk <= '1';
			wait for period_time/2;
		end loop;
		wait;
	end process;

    process
    begin
        wait;
    end process;
end architecture;
