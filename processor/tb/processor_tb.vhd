library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end entity;

architecture a_processor_tb of processor_tb is
    component processor
        port (
            clk: in std_logic;
            rst: in std_logic
        );
    end component;

    constant period_time    : time := 100 ns;
    signal finished         : std_logic := '0';

    signal clk, rst         : std_logic;

begin
    uut: processor port map (
        clk => clk,
        rst => rst
    );

    rst_global: process
    begin	
        rst <= '1';
        wait for period_time * 2;
        rst <= '0';
        wait;
    end process;

    sim_time_proc: process
	begin 
		wait for 150 us;
		finished <= '1';
		wait;
	end process;

    clk_proc: process
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