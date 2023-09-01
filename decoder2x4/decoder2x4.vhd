library ieee;
use ieee.std_logic_1164.all;

entity decoder2x4 is
    port (
        in_1 : in std_logic;
        in_0 : in std_logic;

        out_3: out std_logic;
        out_2: out std_logic;
        out_1: out std_logic;
        out_0: out std_logic
    );
end entity;

architecture a_decord2x4 of decoder2x4 is
    begin
        out_3 <= in_1 and in_0;
        out_2 <= in_1 and not in_0;
        out_1 <= not in_1 and in_0;
        out_0 <= not in_1 and not in_0;
end architecture;