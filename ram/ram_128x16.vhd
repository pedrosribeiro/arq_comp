library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_128x16 is
    port (
        clk     : in std_logic;
        addr    : in unsigned(6 downto 0);      -- 128 addresses
        wr_en   : in std_logic;
        data_in : in unsigned(15 downto 0);
        data_out: out unsigned(15 downto 0)
    );
end entity;

architecture a_ram_128x16 of ram_128x16 is
    type mem is array (0 to 127) of unsigned(15 downto 0);
    signal ram_data: mem;
begin
    process (clk, wr_en)
    begin
        if (rising_edge(clk)) then
            if (wr_en = '1') then
                ram_data(to_integer(addr)) <= data_in;
            end if;
        end if;
    end process;
    data_out <= ram_data(to_integer(addr));
end architecture;
