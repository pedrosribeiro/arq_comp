library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processing_unit is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        wr_en   : in std_logic;

        cte_in      : in unsigned(15 downto 0);
        debug_out   : out unsigned(15 downto 0);

        sel_op : in unsigned(2 downto 0);
        sel: in std_logic;
        read_reg1, read_reg0, write_reg: in unsigned(2 downto 0)
    );
end entity;

architecture a_processing_unit of processing_unit is
    component alu
        port (
            in_1, in_0  : in    unsigned(15 downto 0);
            sel_op      : in    unsigned(2 downto 0);
            out_0       : out   unsigned(15 downto 0);
            N, Z, C, V  : out   std_logic
        );
    end component;

    component reg_bank_8x16
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

    component mux2x1
        port(
            sel         : in std_logic;
            in_1, in_0  : in unsigned(15 downto 0);
            out_0       : out unsigned(15 downto 0)
        );
    end component;

    signal alu_in_1, alu_in_0   : unsigned(15 downto 0);
    signal alu_out              : unsigned(15 downto 0);
    --signal sel_op               : unsigned(2 downto 0);
    signal N, Z, C, V           : std_logic;

    --signal read_reg1, read_reg0, write_reg: unsigned(2 downto 0);
    signal reg_bank_read_data1, reg_bank_read_data0: unsigned(15 downto 0);

    signal mux_in_1, mux_in_0, mux_out : unsigned(15 downto 0);
    --signal sel                         : std_logic;

begin
    
    u0: alu port map (
        in_1 => alu_in_1,
        in_0 => alu_in_0,
        sel_op => sel_op,
        out_0 => alu_out,
        N => N,
        Z => Z,
        C => C,
        V => V
    );

    u1: reg_bank_8x16 port map (
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        read_reg1 => read_reg1,
        read_reg0 => read_reg0,
        write_reg => write_reg,
        data_in => alu_out,
        read_data1 => reg_bank_read_data1,
        read_data0 => reg_bank_read_data0
    );

    mux: mux2x1 port map (
        sel => sel,
        in_1 => mux_in_1,
        in_0 => mux_in_0,
        out_0 => mux_out
    );

    -- reg bank to alu
    alu_in_0 <= reg_bank_read_data0;

    -- reg bank to mux
    mux_in_1 <= reg_bank_read_data1;

    -- constant input to mux
    mux_in_0 <= cte_in;

    -- mux to alu
    alu_in_1 <= mux_out;

    -- processing unit debug
    debug_out <= alu_out;
    
end architecture;