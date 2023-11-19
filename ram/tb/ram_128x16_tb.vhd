library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_128x16_tb is
end entity;

architecture a_ram_128x16_tb of ram_128x16_tb is
    component ram_128x16
        port (
            clk     : in std_logic;
            addr    : in unsigned(6 downto 0);      -- 128 addresses
            wr_en   : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    signal clk, wr_en       : std_logic;
    signal addr             : unsigned(6 downto 0) := "0000000";    -- init with addr 0
    signal data_in, data_out: unsigned(15 downto 0);

    -- clk and rst wave
    constant period_time    : time := 10 ns;
    signal finished         : std_logic := '0';
begin
    uut: ram_128x16 port map (
        clk         => clk,
        addr        => addr,
        wr_en       => wr_en,
        data_in     => data_in,
        data_out    => data_out
    );

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

        for i in 0 to 127 loop      -- writing data to each address
            addr <= to_unsigned(i, 7);
            data_in <= to_unsigned(i, 16);
            wait for 10 ns;
        end loop;

        wr_en <= '0';

        for i in 0 to 127 loop      -- reading data from each address
            addr <= to_unsigned(i, 7);
            data_in <= to_unsigned(i + i, 16);
            wait for 10 ns;
        end loop;
        wait;
    end process;

end architecture;
