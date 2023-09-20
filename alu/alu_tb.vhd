library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end;

architecture a_alu_tb of alu_tb is
    component alu
        port (
            in_1, in_0  : in    unsigned(15 downto 0);
            sel_op      : in    unsigned(2 downto 0);
            out_0       : out   unsigned(15 downto 0);
            N, Z, C, V  : out   std_logic
        );
    end component;

    signal in_1, in_0, out_0: unsigned(15 downto 0);
    signal sel_op           : unsigned(2 downto 0);
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
        -- add_op: "000" --
        sel_op <= "000";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000000001"; -- arbitrary operands        
		in_0 <= "0000000000000010";
		wait for 50 ns;
        in_1 <= "1111111111111111"; -- carry needed
		in_0 <= "0000000000000010";
		wait for 50 ns;

        -- sub_op: "001" --
        sel_op <= "001";
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

        -- and_op: "010" --
        sel_op <= "010";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000001101"; -- arbitrary operands        
		in_0 <= "0000000000001011";
		wait for 50 ns;
        in_1 <= "0000000000000111"; -- equal operands
		in_0 <= "0000000000000111";
		wait for 50 ns;

        -- or_op: "011" --
        sel_op <= "011";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000001101"; -- arbitrary operands        
		in_0 <= "0000000000001011";
		wait for 50 ns;
        in_1 <= "0000000000000111"; -- equal operands
		in_0 <= "0000000000000111";
		wait for 50 ns;

        -- not_op: "100" --
        sel_op <= "100";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000001101"; -- arbitrary operands        
		in_0 <= "0000000000001011";
		wait for 50 ns;
        in_1 <= "0000000000000111"; -- equal operands
		in_0 <= "0000000000000111";
		wait for 50 ns;

        -- eq_cmp: "101" --
        sel_op <= "101";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000001101"; -- not equal operands        
		in_0 <= "0000000000001011";
		wait for 50 ns;
        in_1 <= "0000000000000111"; -- equal operands
		in_0 <= "0000000000000111";
		wait for 50 ns;

        -- gt_cmp: "110" --
        sel_op <= "110";
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

        -- inc_op: "111" --
        sel_op <= "111";
        in_1 <= "0000000000000000"; -- operands zero
		in_0 <= "0000000000000000";
		wait for 50 ns;
        in_1 <= "0000000000001101"; -- arbitrary operands        
		in_0 <= "0000000000001011";
		wait for 50 ns;
        in_1 <= "1111111111111111"; -- carry needed
		in_0 <= "0000000000001101";
		wait for 50 ns;

        wait;
    end process;
end architecture;
