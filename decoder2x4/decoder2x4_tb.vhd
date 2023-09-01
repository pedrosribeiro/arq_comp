library ieee;
use ieee.std_logic_1164.all;

entity decoder2x4_tb is
end;

architecture a_decoder2x4_tb of decoder2x4_tb is
    component decoder2x4
        port (
            in_1 : in std_logic;
            in_0 : in std_logic;

            out_3: out std_logic;
            out_2: out std_logic;
            out_1: out std_logic;
            out_0: out std_logic
        );
    end component;

    signal in_1, in_0, out_3, out_2, out_1, out_0: std_logic;
    begin
        uut: decoder2x4 port map (
            in_1  => in_1,
            in_0  => in_0,

            out_3 => out_3,
            out_2 => out_2,
            out_1 => out_1,
            out_0 => out_0
        );
    
    process
        begin
            in_1 <= '0';
            in_0 <= '0';
            wait for 50 ns;
            in_1 <= '0';
            in_0 <= '1';
            wait for 50 ns;
            in_1 <= '1';
            in_0 <= '0';
            wait for 50 ns;
            in_1 <= '1';
            in_0 <= '1';
            wait for 50 ns;
            wait;
    end process;
end architecture;