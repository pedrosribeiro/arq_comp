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
        0   => "0011" & "0000001010" & "001",               -- MOVEI.W #$10, D1

        1   => "0011" & "0000010100" & "010",               -- MOVEI.W #$20, D2

        2   => "1001" & "0000000" & "001" & "010",          -- SW.W D1, (D2)

        3   => "1001" & "0000000" & "010" & "001",          -- SW.W D2, (D1)

        4   => "0001" & "0000000" & "001" & "010",          -- ADD.W D1, D2

        5   => "1000" & "0000000" & "001" & "011",          -- LW.W (D1), D3

        6   => "0011" & "0000000100" & "100",               -- MOVEI.W #$4, D4

        7   => "0001" & "0000000" & "011" & "100",          -- ADD.W D3, D4

        8   => "0001" & "0000000" & "000" & "100",          -- ADD.W D0, D4
        
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
