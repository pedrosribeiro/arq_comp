library ieee;
use ieee.std_logic_1164.all;

entity three_bit_parity_checker is
    port (
        in_2 : in std_logic;
        in_1 : in std_logic;
        in_0 : in std_logic;

        out_0: out std_logic
    );
end entity;

architecture a_three_bit_parity_checker of three_bit_parity_checker is
begin
    out_0 <= (in_2 and not in_1 and not in_0) or (not in_2 and in_1 and not in_0) or (not in_2 and not in_1 and in_0) or (in_2 and in_1 and in_0);
end architecture;