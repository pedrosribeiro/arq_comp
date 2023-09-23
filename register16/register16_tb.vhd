library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register16_tb is
end entity;

architecture a_register16_tb of register16_tb is
    component register16 is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    constant period_time    : time := 100 ns;
    signal finished         : std_logic := '0';
    signal clk, rst, wr_en  : std_logic;
    signal data_in, data_out: unsigned(15 downto 0);
    
begin
    uut: register16
        port map (
            clk         => clk,
            rst         => rst,
            wr_en       => wr_en,
            data_in     => data_in,
            data_out    => data_out
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
		wait for 10 us;
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
		wait for 200 ns;
        wr_en <= '0';
        data_in <= "1111111111111111";
        wait for 100 ns;
        data_in <= "0000000000000001";
        wait for 100 ns;
        wr_en <= '1';
        data_in <= "0000000000000010";
        wait for 100 ns;
        data_in <= "0000000000000011";
        wait for 100 ns;
        data_in <= "0000000000000100";
        wait for 100 ns;
        wr_en <= '0';
        data_in <= "0000000000000101";
        wait for 100 ns;
		wait;
	end process;
    
end architecture;
