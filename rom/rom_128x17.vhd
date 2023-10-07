library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_128x17 is
    port (
        clk         : in std_logic;                 -- synchronous rom
        addr        : in unsigned(6 downto 0);      -- 128 addresses
        data_out    : out unsigned(16 downto 0)     -- 17 bits of data
    );
end entity;

architecture a_rom_128x17 of rom_128x17 is
    type mem is array (0 to 127) of unsigned(16 downto 0); -- 128 addresses, 17 bits of data
    constant rom_data: mem := (
        -- case addr => data
        0   => "00000000000000000",
        1   => "00000000000000001",
        2   => "00000000000000010",
        3   => "00000000000000011",
        4   => "00000000000000100",
        5   => "00000000000000101",
        6   => "00000000000000110",
        7   => "00000000000000111",
        8   => "00000000000001000",
        9   => "00000000000001001",
        10  => "00000000000001010",
        -- omitted cases
        others => (others => '0')
    );

begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            data_out <= rom_data(to_integer(addr));
        end if;
    end process;
end architecture ;
