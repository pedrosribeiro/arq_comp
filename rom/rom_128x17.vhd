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
        0   => "0011" & "0000000000" & "011",               -- MOVEI.W #$0, D3      (0x06003)

        1   => "0011" & "0000000000" & "100",               -- MOVEI.W #$0, D4      (0x06004)

        2   => "0011" & "0000000000" & "101",               -- MOVEI.W #$0, D5      (0x06005)

        3   => "0011" & "0000000001" & "001",               -- MOVEI.W #$1, D1      (0x06009)

        4   => "0011" & "0000011110" & "010",               -- MOVEI.W #$30, D2     (0x060F2)

        5   => "0001" & "0000000" & "011" & "100",          -- ADD.W D3, D4         (0x0201C)

        6   => "0001" & "0000000" & "001" & "011",          -- ADD.W D1, D3         (0x0200B)

        7   => "0101" & "0000000" & "010" & "011",          -- CMP.W D2, D3         (0X0A013)

        8   => "0111" & "00000"  & "1" & "1111101",         -- BLT.S #$-3           (0x0E183)

        9   => "0100" & "0000000" & "100" & "101",          -- MOVE.W D4, D5        (0x08025)
        
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
