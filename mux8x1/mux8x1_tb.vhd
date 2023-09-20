library ieee;
use ieee.std_logic_1164.all;

entity mux8x1_tb is
end;

architecture a_mux8x1_tb of mux8x1_tb is
    component mux8x1
        port (
            sel_2, sel_1, sel_0 : in std_logic;
            in_6, in_4, in_2    : in std_logic;
            out_0               : out std_logic
        );
    end component;

    signal sel_2, sel_1, sel_0, in_6, in_4, in_2, out_0: std_logic;
    begin
        uut: mux8x1 
            port map (
                sel_2  => sel_2,
                sel_1  => sel_1,
                sel_0  => sel_0,

                in_6  => in_6,
                in_4  => in_4,
                in_2  => in_2,

                out_0 => out_0
            );
    
    process
        begin
            in_6 <= '1';
            in_4 <= '1';
            in_2 <= '1';

            sel_2 <= '0';
            sel_1 <= '0';
            sel_0 <= '0';

            wait for 50 ns;

            sel_2 <= '0';
            sel_1 <= '0';
            sel_0 <= '1';

            wait for 50 ns;

            sel_2 <= '0';
            sel_1 <= '1';
            sel_0 <= '0';

            wait for 50 ns;

            sel_2 <= '0';
            sel_1 <= '1';
            sel_0 <= '1';

            wait for 50 ns;

            sel_2 <= '1';
            sel_1 <= '0';
            sel_0 <= '0';

            wait for 50 ns;

            sel_2 <= '1';
            sel_1 <= '0';
            sel_0 <= '1';

            wait for 50 ns;

            sel_2 <= '1';
            sel_1 <= '1';
            sel_0 <= '0';

            wait for 50 ns;

            sel_2 <= '1';
            sel_1 <= '1';
            sel_0 <= '1';

            wait for 50 ns;
            wait;
    end process;
end architecture;