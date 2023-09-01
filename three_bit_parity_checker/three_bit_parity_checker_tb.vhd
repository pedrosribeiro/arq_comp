library ieee;
use ieee.std_logic_1164.all;

entity three_bit_parity_checker_tb is
end;

architecture a_three_bit_parity_checker_tb of three_bit_parity_checker_tb is
    component three_bit_parity_checker
        port (
            in_2 : in std_logic;
            in_1 : in std_logic;
            in_0 : in std_logic;

            out_0: out std_logic
        );
    end component;

    signal in_2, in_1, in_0, out_0: std_logic;
    begin
        uut: three_bit_parity_checker port map (
            in_2  => in_2,
            in_1  => in_1,
            in_0  => in_0,

            out_0 => out_0
        );
    
    process
        begin
            in_2 <= '0';
            in_1 <= '0';
            in_0 <= '0';
            wait for 50 ns;
            in_2 <= '0';
            in_1 <= '0';
            in_0 <= '1';
            wait for 50 ns;
            in_2 <= '0';
            in_1 <= '1';
            in_0 <= '0';
            wait for 50 ns;
            in_2 <= '0';
            in_1 <= '1';
            in_0 <= '1';
            wait for 50 ns;
            in_2 <= '1';
            in_1 <= '0';
            in_0 <= '0';
            wait for 50 ns;
            in_2 <= '1';
            in_1 <= '0';
            in_0 <= '1';
            wait for 50 ns;
            in_2 <= '1';
            in_1 <= '1';
            in_0 <= '0';
            wait for 50 ns;
            in_2 <= '1';
            in_1 <= '1';
            in_0 <= '1';
            wait for 50 ns;
            wait;
        end process;
end architecture;
