library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_mach_2_tb is
end entity;

architecture state_mach_2_tb of state_mach_2_tb is
    component state_mach_2 is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            state   : out std_logic     -- 2 states
        );
    end component;

    -- clk wave
    constant period_time    : time := 10 ns;
    signal finished         : std_logic := '0';

    signal clk, rst, state  : std_logic;
begin

    uut: state_mach_2 port map (
        clk     => clk,
        rst     => rst,
        state   => state
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
