library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end;

architecture a_alu_tb of alu_tb is
    component alu
        port (
            in_1, in_0  : in    unsigned(15 downto 0);
            sel_op      : in    unsigned(1 downto 0);
            out_0       : out   unsigned(15 downto 0);
            N, Z, C, V  : out   std_logic               -- negative, zero, carry and overflow flags
        );
    end component;

    signal in_1, in_0, out_0: unsigned(15 downto 0);
    signal sel_op           : unsigned(1 downto 0);
    signal N, Z, C, V       : std_logic;

    begin
        uut: alu 
            port map (
                in_1    => in_1,
                in_0    => in_0,
                sel_op  => sel_op,
                out_0   => out_0,
                N       => N,
                Z       => Z,
                C       => C,
                V       => V
            );
    
    process
    begin
        -- add_op: "00" --
        sel_op <= "00";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000000001"; -- arbitrary operands        
		in_0 <= "0000000000000010";
		wait for 50 ns;
        in_1 <= "1111111111111111"; -- carry needed
		in_0 <= "0000000000000010";
		wait for 50 ns;

        -- sub_op: "01" --
        sel_op <= "01";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000000101"; -- arbitrary operands        
		in_0 <= "0000000000000011";
		wait for 50 ns;
        in_1 <= "0000000000000011"; -- borrow needed
		in_0 <= "0000000000000101";
		wait for 50 ns;
        in_1 <= "0000000000000111"; -- equal operands
		in_0 <= "0000000000000111";
		wait for 50 ns;

        -- eq_cmp: "10" --
        sel_op <= "10";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000001101"; -- not equal operands        
		in_0 <= "0000000000001011";
		wait for 50 ns;
        in_1 <= "0000000000000111"; -- equal operands
		in_0 <= "0000000000000111";
		wait for 50 ns;

        -- gt_cmp: "11" --
        sel_op <= "11";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000001101"; -- in_1 greater than in_0        
		in_0 <= "0000000000001011";
		wait for 50 ns;
        in_1 <= "0000000000000111"; -- equal operands
		in_0 <= "0000000000000111";
		wait for 50 ns;
        in_1 <= "0000000000001011"; -- in_1 lower than in_0
		in_0 <= "0000000000001101";
		wait for 50 ns;

        wait;
    end process;
end architecture;
