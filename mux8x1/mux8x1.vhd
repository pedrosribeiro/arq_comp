library ieee;
use ieee.std_logic_1164.all;

entity mux8x1 is
    port (
        sel_2, sel_1, sel_0 : in std_logic;
        in_6, in_4, in_2    : in std_logic;
        out_0               : out std_logic
    );
end entity;

architecture a_mux8x1 of mux8x1 is
begin
    out_0 <=    in_2 when sel_2='0' and sel_1='1' and sel_0='0' else
                in_4 when sel_2='1' and sel_1='0' and sel_0='0' else
                in_6 when sel_2='1' and sel_1='1' and sel_0='0' else

                '1'  when sel_2='0' and sel_1='1' and sel_0='1' else
                '1'  when sel_2='1' and sel_1='1' and sel_0='1' else

                '0';
end architecture;
