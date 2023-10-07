library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_7_tb is
end entity;

architecture a_pc_7_tb of pc_7_tb is
    component pc_7 is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(6 downto 0); -- 0 to 127
            data_out: out unsigned(6 downto 0)
        );
    end component;
    
    -- clk wave
    constant period_time    : time := 10 ns;
    signal finished         : std_logic := '0';

    signal clk, rst, wr_en  : std_logic;
    signal data_in_s, data_out_s: unsigned(6 downto 0);
begin
    -- instance
    uut: pc_7 port map (
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        data_in => data_in_s,
        data_out => data_out_s
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

    -- stimulation process
    process
    begin
        wr_en <= '1';
        wait for period_time*2;

        for i in 0 to 127 loop      -- generate next value every 10 ns
            data_in_s <= to_unsigned(i, 7);
            wait for 10 ns;
        end loop;

        wait;
    end process;

end architecture;
