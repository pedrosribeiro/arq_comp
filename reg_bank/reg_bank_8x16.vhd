library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bank_8x16 is
    port (
        clk: in std_logic;
        rst: in std_logic;
        wr_en: in std_logic;

        -- 8 possible registers
        read_reg1: in unsigned(2 downto 0);
        read_reg0: in unsigned(2 downto 0);
        write_reg: in unsigned(2 downto 0);

        data_in: in unsigned(15 downto 0);

        read_data1: out unsigned(15 downto 0);
        read_data0: out unsigned(15 downto 0)
    );
end entity;

architecture a_reg_bank_8x16 of reg_bank_8x16 is
    component register16 is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    constant ZERO   : unsigned(15 downto 0) := "0000000000000000";

    signal wr_en7, wr_en6, wr_en5, wr_en4, wr_en3, wr_en2, wr_en1: std_logic;
    signal data_out7, data_out6, data_out5, data_out4, data_out3, data_out2, data_out1, data_out0: unsigned(15 downto 0);

begin
    register16_7: register16 port map (clk => clk, rst => rst, wr_en => wr_en7, data_in => data_in, data_out => data_out7);
    register16_6: register16 port map (clk => clk, rst => rst, wr_en => wr_en6, data_in => data_in, data_out => data_out6);
    register16_5: register16 port map (clk => clk, rst => rst, wr_en => wr_en5, data_in => data_in, data_out => data_out5);
    register16_4: register16 port map (clk => clk, rst => rst, wr_en => wr_en4, data_in => data_in, data_out => data_out4);
    register16_3: register16 port map (clk => clk, rst => rst, wr_en => wr_en3, data_in => data_in, data_out => data_out3);
    register16_2: register16 port map (clk => clk, rst => rst, wr_en => wr_en2, data_in => data_in, data_out => data_out2);
    register16_1: register16 port map (clk => clk, rst => rst, wr_en => wr_en1, data_in => data_in, data_out => data_out1);
    register16_0: register16 port map (clk => clk, rst => '1', wr_en => '0',    data_in => data_in, data_out => data_out0); -- register zero can not be written

    read_data1 <=   data_out0 when read_reg1 = "000" else
                    data_out1 when read_reg1 = "001" else
                    data_out2 when read_reg1 = "010" else
                    data_out3 when read_reg1 = "011" else
                    data_out4 when read_reg1 = "100" else
                    data_out5 when read_reg1 = "101" else
                    data_out6 when read_reg1 = "110" else
                    data_out7 when read_reg1 = "111" else
                    ZERO;
    
    read_data0 <=   data_out0 when read_reg0 = "000" else
                    data_out1 when read_reg0 = "001" else
                    data_out2 when read_reg0 = "010" else
                    data_out3 when read_reg0 = "011" else
                    data_out4 when read_reg0 = "100" else
                    data_out5 when read_reg0 = "101" else
                    data_out6 when read_reg0 = "110" else
                    data_out7 when read_reg0 = "111" else
                    ZERO;
    
    -- only allows the destination register to be written
    wr_en7 <= wr_en when write_reg = "111" else '0';
    wr_en6 <= wr_en when write_reg = "110" else '0';
    wr_en5 <= wr_en when write_reg = "101" else '0';
    wr_en4 <= wr_en when write_reg = "100" else '0';
    wr_en3 <= wr_en when write_reg = "011" else '0';
    wr_en2 <= wr_en when write_reg = "010" else '0';
    wr_en1 <= wr_en when write_reg = "001" else '0';
    
end architecture;