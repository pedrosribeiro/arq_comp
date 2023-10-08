library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processing_unit_proto_tb is
end entity;

architecture a_processing_unit_proto_tb of processing_unit_proto_tb is
    component processing_unit_proto
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
    
            cte_in      : in unsigned(15 downto 0);
            debug_out   : out unsigned(15 downto 0);

            sel_op                         : in unsigned(2 downto 0);
            sel                            : in std_logic;
            read_reg1, read_reg0, write_reg: in unsigned(2 downto 0)
        );
    end component;

    constant period_time    : time := 100 ns;
    signal finished         : std_logic := '0';

    signal clk, rst, wr_en  : std_logic;
    signal cte_in, debug_out: unsigned(15 downto 0);

    signal sel_op                           : unsigned(2 downto 0);
    signal read_reg1, read_reg0, write_reg  : unsigned(2 downto 0);
    signal sel                              : std_logic;

begin
    uut: processing_unit_proto port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        cte_in => cte_in,
        debug_out => debug_out,
        sel_op => sel_op,
        read_reg1 => read_reg1,
        read_reg0 => read_reg0,
        write_reg => write_reg,
        sel => sel
    );

    rst_global: process
    begin	
        rst <= '1';
        wait for period_time * 2;
        rst <= '0';
        wait;
    end process;

    sim_time_proc: process
	begin 
		wait for 10 us;
		finished <= '1';
		wait;
	end process;

    clk_proc: process
	begin 
		while finished /= '1' loop
			clk <= '0';
			wait for period_time/2;
			clk <= '1';
			wait for period_time/2;
		end loop;
		wait;
	end process;
    
    process
    begin
        wr_en <= '0';
        cte_in <= "0000000000000000";
        sel_op <= "000";
        sel <= '0';
        read_reg1 <= "000";
        read_reg0 <= "000";
        write_reg <= "000";
        rst <= '1';
        wait for 200 ns;
        rst <= '0';
        wait for 100 ns;
        -- stores 1 in reg1
        wr_en <= '1';
        cte_in <= "0000000000000001";
        write_reg <= "001";
        wait for 100 ns;
        -- stores 2 in reg2
        cte_in <= "0000000000000010";
        write_reg <= "010";
        wait for 100 ns;
        -- stores 3 in reg3
        cte_in <= "0000000000000011";
        write_reg <= "011";
        wait for 100 ns;
        wr_en <= '0';
        read_reg0 <= "001";
        wait for 100 ns;
        read_reg0 <= "010";
        wait for 100 ns;
        read_reg0 <= "011";
        wait for 100 ns;
        sel <= '1'; -- alu inputs are read from bank
        read_reg0 <= "001";
        read_reg1 <= "010";
        wait for 100 ns;
        sel_op <= "000"; -- add_op (2 + 1 = 3)
        wait for 100 ns;
        sel_op <= "001"; -- sub_op (2 - 1 = 1)
        wait for 100 ns;
        sel_op <= "010"; -- and_op (2 AND 1 = 0)
        wait for 100 ns;
        sel_op <= "011"; -- or_op (2 OR 1 = 3)
        wait for 100 ns;
        sel_op <= "100"; -- not_op (NOT 2 = FFFD)
        wait for 100 ns;
        sel_op <= "101"; -- eq_cmp (2 == 1 => 0)
        wait for 100 ns;
        sel_op <= "110"; -- gt_cmp (2 > 1 => 1)
        wait for 100 ns;
        sel_op <= "111"; -- inc_op (2++ => 3)
        wait for 100 ns;
        wr_en <= '1';
        write_reg <= "100"; -- reg4 <= 3;
        wait for 100 ns;
        wr_en <= '0';
        read_reg0 <= "100";
        wait for 100 ns;
        wr_en <= '1';
        sel_op <= "000";
        read_reg0 <= "000";
        sel <= '0';
        cte_in <= "1010101010101010"; -- (AAAA)16
        write_reg <= "111";
        wait for 100 ns;
        wr_en <= '0';
        wait for 100 ns;
        sel <= '1';
        read_reg1 <= "000";
        read_reg0 <= "111";
        wait for 100 ns;
        wait;
    end process;
    
end architecture;