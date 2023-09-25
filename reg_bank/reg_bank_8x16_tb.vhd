library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bank_8x16_tb is
end entity;

architecture a_reg_bank_8x16_tb of reg_bank_8x16_tb is
    component reg_bank_8x16 is
        port (
            clk: in std_logic;
            rst: in std_logic;
            wr_en: in std_logic;

            read_reg1: in unsigned(2 downto 0);
            read_reg0: in unsigned(2 downto 0);
            write_reg: in unsigned(2 downto 0);
    
            data_in: in unsigned(15 downto 0);
    
            read_data1: out unsigned(15 downto 0);
            read_data0: out unsigned(15 downto 0)
        );
    end component;

    constant period_time    : time := 100 ns;
    signal finished         : std_logic := '0';

    signal clk, rst, wr_en                  : std_logic;
    signal read_reg1, read_reg0, write_reg  : unsigned(2 downto 0);
    signal data_in, read_data1, read_data0  : unsigned(15 downto 0);

begin
    uut: reg_bank_8x16
        port map (
            clk => clk,
            rst => rst,
            wr_en => wr_en,
            read_reg1 => read_reg1,
            read_reg0 => read_reg0,
            write_reg => write_reg,
            data_in => data_in,
            read_data1 => read_data1,
            read_data0 => read_data0
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
        read_reg1 <= "000";
        read_reg0 <= "000";
        write_reg <= "000";
        data_in <= "0000000000000000";
        wait for 200 ns;
        data_in <= "0000000000000001";
        write_reg <= "001";
        wr_en <= '1';
        read_reg0 <= "001";
        wait for 100 ns;
        data_in <= "0000000000000010";
        write_reg <= "010";
        wr_en <= '1';
        read_reg0 <= "010";
        wait for 100 ns;
        data_in <= "0000000000000011";
        write_reg <= "011";
        wr_en <= '0';
        read_reg0 <= "011";
        wait for 100 ns;
        data_in <= "0000000000000100";
        write_reg <= "100";
        wr_en <= '1';
        read_reg1 <= "011";
        read_reg0 <= "100";
        wait for 100 ns;
        wr_en <= '0';
        read_reg1 <= "010";
        read_reg0 <= "100";
        wait for 100 ns;
        wait;
    end process;
    
end architecture;
