library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_128x17_tb is
end entity;

architecture rom_128x17_tb of rom_128x17_tb is
    component rom_128x17 is
        port (
            clk         : in std_logic;                 -- synchronous rom
            addr        : in unsigned(6 downto 0);      -- 128 addresses
            data_out    : out unsigned(16 downto 0)     -- 17 bits of data
        );
    end component;

    -- clk wave
    constant period_time    : time := 10 ns;
    signal finished         : std_logic := '0';

    signal clk      : std_logic;
    signal addr     : unsigned(6 downto 0) := "0000000";    -- init with addr 0
    signal data_out : unsigned(16 downto 0);
begin
    uut: rom_128x17 port map (
        clk         => clk,
        addr        => addr,
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
        for i in 0 to 127 loop      -- generate next address every 10 ns
            addr <= to_unsigned(i, 7);
            wait for 10 ns;
        end loop;
        wait;
    end process;

end architecture;
