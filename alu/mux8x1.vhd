library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x1 is
    port(
        sel                                             : in unsigned(2 downto 0);
        in_7, in_6, in_5, in_4, in_3, in_2, in_1, in_0  : in unsigned(15 downto 0);
        out_0                                           : out unsigned(15 downto 0)
    );
end entity;

architecture a_mux8x1 of mux8x1 is
begin
    out_0 <=    in_0 when sel="000" else
                in_1 when sel="001" else
                in_2 when sel="010" else
                in_3 when sel="011" else
                in_4 when sel="100" else
                in_5 when sel="101" else
                in_6 when sel="110" else
                in_7 when sel="111" else
                "0000000000000000";
end architecture;
