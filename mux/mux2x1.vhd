library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1 is
    port(
        sel         : in std_logic;
        in_1, in_0  : in unsigned(15 downto 0);
        out_0       : out unsigned(15 downto 0)
    );
end entity;

architecture a_mux2x1 of mux2x1 is
begin
    out_0 <=    in_0 when sel='0' else
                in_1 when sel='1' else
                "0000000000000000";
end architecture;
