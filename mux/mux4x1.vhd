library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1 is
    port(
        sel                     : in unsigned(1 downto 0);
        in_3, in_2, in_1, in_0  : in unsigned(15 downto 0);
        out_0                   : out unsigned(15 downto 0)
    );
end entity;

architecture a_mux4x1 of mux4x1 is
begin
    out_0 <=    in_0 when sel="00" else
                in_1 when sel="01" else
                in_2 when sel="10" else
                in_3 when sel="11" else
                "0000000000000000";
end architecture;
