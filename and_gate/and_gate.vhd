library ieee;
use ieee.std_logic_1164.all;

entity and_gate is
    port (
        in_1: in std_logic;
        in_0: in std_logic;

        out_0: out std_logic
    );
end entity;

architecture a_and_gate of and_gate is
    begin
        out_0 <= in_1 and in_0;
end architecture;