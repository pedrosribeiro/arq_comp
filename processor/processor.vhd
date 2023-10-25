library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port (
        clk: in std_logic;
        rst: in std_logic
    );
end entity;

architecture a_processor of processor is
    component alu is
        port (
            in_1, in_0  : in    unsigned(15 downto 0);
            sel_op      : in    unsigned(1 downto 0);
            out_0       : out   unsigned(15 downto 0);
            N, Z, C, V  : out   std_logic               -- negative, zero, carry and overflow flags
        );
    end component;

    signal alu_out: unsigned(15 downto 0);
    signal N, Z, C, V: std_logic;

    component mux2x1 is
        port(
            sel         : in std_logic;
            in_1, in_0  : in unsigned(15 downto 0);
            out_0       : out unsigned(15 downto 0)
        );
    end component;

    signal alu_src_mux_out: unsigned(15 downto 0);

    component reg_bank_8x16 is
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
    end component;

    signal read_reg1, read_reg0, write_reg: unsigned(2 downto 0);
    signal reg_bank_data_in, reg_bank_read_data1, reg_bank_read_data0: unsigned(15 downto 0);

    component pc_7 is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(6 downto 0); -- 0 to 127
            data_out: out unsigned(6 downto 0)
        );
    end component;

    signal pc_data_in, pc_data_out: unsigned(6 downto 0);

    component rom_128x17 is
        port (
            clk         : in std_logic;                 -- synchronous rom
            addr        : in unsigned(6 downto 0);      -- 128 addresses
            data_out    : out unsigned(16 downto 0)     -- 17 bits of data
        );
    end component;

    signal rom_data_out: unsigned(16 downto 0);

    component control_unit is
        port (
            clk             : in std_logic;
            rst             : in std_logic;
            instruction     : in unsigned(16 downto 0); -- rom instruction
            wr_en_pc        : out std_logic;            -- program counter write enable
            wr_en_inst_reg  : out std_logic;            -- instruction register write enable
            alu_src         : out std_logic;
            reg_write       : out std_logic;            -- register bank write enable
            jump_en         : out std_logic;
            alu_op          : out unsigned(1 downto 0)
        );
    end component;

    signal wr_en_pc, wr_en_inst_reg, reg_write, alu_src, jump_en: std_logic;
    signal alu_op: unsigned(1 downto 0);

    component register17
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(16 downto 0);
            data_out: out unsigned(16 downto 0)
        );
    end component;

    signal inst_reg_data_out: unsigned(16 downto 0);

    signal immediate: unsigned(15 downto 0);

begin
    -- alu instance
    alu_processor: alu port map (
        in_1    => reg_bank_read_data1,     -- reg bank
        in_0    => alu_src_mux_out,
        sel_op  => alu_op,                  -- control unit
        out_0   => alu_out,
        N       => N,
        Z       => Z,
        C       => C,
        V       => v
    );

    alu_src_mux: mux2x1 port map (
        sel     => alu_src,                 -- control unit
        in_1    => immediate,               -- rom instruction hardcoded value
        in_0    => reg_bank_read_data0,     -- register bank
        out_0   => alu_src_mux_out
    );

    -- reg_bank instance
    reg_bank: reg_bank_8x16 port map (
        clk         => clk,
        rst         => rst,
        wr_en       => reg_write,           -- control unit
        read_reg1   => read_reg1,
        read_reg0   => read_reg0,
        write_reg   => write_reg,           -- control unit
        data_in     => reg_bank_data_in,
        read_data1  => reg_bank_read_data1,
        read_data0  => reg_bank_read_data0
    );

    -- pc instance
    pc: pc_7 port map (
        clk         => clk,
        rst         => rst,
        wr_en       => wr_en_pc,            -- control unit
        data_in     => pc_data_in,
        data_out    => pc_data_out
    );

    -- rom instance
    rom: rom_128x17 port map (
        clk         => clk,
        addr        => pc_data_out,         -- pc
        data_out    => rom_data_out
    );

    -- control unit instance
    control_unit_processor: control_unit port map (
        clk             => clk,
        rst             => rst,
        instruction     => rom_data_out,    -- rom
        wr_en_pc        => wr_en_pc,
        wr_en_inst_reg  => wr_en_inst_reg,
        alu_src         => alu_src,
        reg_write       => reg_write,
        jump_en         => jump_en,
        alu_op          => alu_op
    );
    
    -- instruction register instance
    inst_reg: register17 port map (
        clk         => clk,
        rst         => rst,
        wr_en       => wr_en_inst_reg,      -- control unit
        data_in     => rom_data_out,        -- rom
        data_out    => inst_reg_data_out
    );

    -- to do: pc increment logic
    -- get jump address

end architecture;