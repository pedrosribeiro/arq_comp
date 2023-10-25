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
        0   => "00000000000000000",                 -- NOP                  (0x00000)

        1   => "0011" & "0000000101" & "011",       -- MOVEI.W #$5, D3      (0x0602B)

        2   => "0011" & "0000001000" & "100",       -- MOVEI.W #$8, D4      (0x06044)

        3   => "0011" & "0000000000" & "101",       -- MOVEI.W #$0, D5      (0x06005)

        4   => "0001" & "0000000" & "011" & "101",  -- Label: ADD.W D3, D5  (0x0201D)

        5   => "0001" & "0000000" & "100" & "101",  -- ADD.W D4, D5         (0x02025)

        6   => "0011" & "0000000001" & "001",       -- MOVEI.W #$1, D1      (0x06009)

        7   => "0010" & "0000000" & "001" & "101",  -- SUB.W D1, D5         (0x0400D)

        8   => "1111" & "000000" & "0010100",       -- JMP $20              (0x1E014)

        20  => "0100" & "0000000" & "101" & "011",  -- MOVE.W D5, D3        (0x0802B)

        21  => "1111" & "000000" & "0000100",       -- JMP Label            (0x1E004)
        
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
