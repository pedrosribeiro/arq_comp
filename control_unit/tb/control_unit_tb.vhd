library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity;

architecture a_control_unit_tb of control_unit_tb is
    component control_unit
        port (
            clk         : in std_logic;
            rst         : in std_logic
        );
    end component;

    -- clk and rst waves
    constant period_time    : time := 100 ns;
    signal finished         : std_logic := '0';

    signal clk, rst : std_logic;
begin
    -- instance
    uut: control_unit port map (
        clk         => clk,
        rst         => rst
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