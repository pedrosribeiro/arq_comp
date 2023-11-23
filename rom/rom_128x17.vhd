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
        0   => "0011" & "0000001010" & "001",               -- MOVEI.W #$10, D1     (0x06051)

        1   => "0011" & "0000010100" & "010",               -- MOVEI.W #$20, D2     (0x060A2)

        2   => "0011" & "0000011110" & "011",               -- MOVEI.W #$30, D3     (0x060F3)

        3   => "0011" & "0000101000" & "100",               -- MOVEI.W #$40, D4     (0x06144)

        4   => "1001" & "0000000" & "001" & "010",          -- MOVE.W D1, (D2)      (0x1200A)

        5   => "1001" & "0000000" & "010" & "011",          -- MOVE.W D2, (D3)      (0x12013)

        6   => "1001" & "0000000" & "011" & "100",          -- MOVE.W D3, (D4)      (0x1201C)

        7   => "0001" & "0000000" & "011" & "100",          -- ADD.W D3, D4         (0x0201C)

        8   => "1001" & "0000000" & "100" & "001",          -- MOVE.W D4, (D1)      (0x12021)

        9   => "0011" & "0000000001" & "101",               -- MOVEI.W #$1, D5      (0x0600D)

        10  => "1000" & "0000000" & "001" & "010",          -- MOVE.W (D1), D2      (0x1000A)

        11  => "0001" & "0000000" & "000" & "010",          -- ADD.W D0, D2         (0x02002)
        
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
