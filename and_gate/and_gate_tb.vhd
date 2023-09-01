library ieee;
use ieee.std_logic_1164.all;

entity and_gate_tb is
end;

architecture a_and_gate_tb of and_gate_tb is
    component and_gate
        port (
            in_1: in std_logic;
            in_0: in std_logic;

            out_0: out std_logic
        );
    end component;

    signal in_1, in_0, out_0: std_logic;
    begin
        -- uut means unit under test
        uut: and_gate port map (
            in_1 => in_1,
            in_0 => in_0,
            
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