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
    signal reg_bank_read_data1, reg_bank_read_data0: unsigned(15 downto 0);

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
            flags_wr_en     : out std_logic;            -- flags registers write enable
            alu_op          : out unsigned(1 downto 0)
        );
    end component;

    signal wr_en_pc, wr_en_inst_reg, reg_write, alu_src, jump_en, flags_wr_en: std_logic;
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

    component register1
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in std_logic;
            data_out: out std_logic
        );
    end component;

    -- cmp flags registers
    signal n_flag_cmp_data_out, z_flag_cmp_data_out, c_flag_cmp_data_out, v_flag_cmp_data_out: std_logic;

    signal immediate    : unsigned(15 downto 0);
    signal jmp_addr     : unsigned(6 downto 0);
    signal opcode       : unsigned(3 downto 0);

    -- opcodes
    constant nop_opcode     : unsigned(3 downto 0) := "0000";
    constant add_opcode     : unsigned(3 downto 0) := "0001";
    constant sub_opcode     : unsigned(3 downto 0) := "0010";
    constant movei_opcode   : unsigned(3 downto 0) := "0011";
    constant move_opcode    : unsigned(3 downto 0) := "0100";
    constant cmp_opcode     : unsigned(3 downto 0) := "0101";
    constant beq_opcode     : unsigned(3 downto 0) := "0110";
    constant blt_opcode     : unsigned(3 downto 0) := "0111";
    constant jmp_opcode     : unsigned(3 downto 0) := "1111";

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
        V       => V
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
        data_in     => alu_out,             -- alu
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
        flags_wr_en     => flags_wr_en,
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

    -- n flag register instance
    n_flag_cmp: register1 port map (
        clk         => clk,
        rst         => rst,
        wr_en       => flags_wr_en,
        data_in     => N,                   -- alu
        data_out    => n_flag_cmp_data_out
    );

    -- z flag register instance
    z_flag_cmp: register1 port map (
        clk         => clk,
        rst         => rst,
        wr_en       => flags_wr_en,
        data_in     => Z,                   -- alu
        data_out    => z_flag_cmp_data_out
    );

    -- c flag register instance
    c_flag_cmp: register1 port map (
        clk         => clk,
        rst         => rst,
        wr_en       => flags_wr_en,
        data_in     => C,                   -- alu
        data_out    => c_flag_cmp_data_out
    );

    -- v flag register instance
    v_flag_cmp: register1 port map (
        clk         => clk,
        rst         => rst,
        wr_en       => flags_wr_en,
        data_in     => V,                   -- alu
        data_out    => v_flag_cmp_data_out
    );

    opcode <= inst_reg_data_out(16 downto 13);      -- 4 MSB of instruction

    -- source register
    read_reg0 <= "000" when 
                            (
                                opcode = nop_opcode OR
                                opcode = movei_opcode OR
                                opcode = beq_opcode OR
                                opcode = blt_opcode OR
                                opcode = jmp_opcode
                            )
                    else inst_reg_data_out(5 downto 3);
    
    -- destination register
    read_reg1 <=    "000" when (opcode = move_opcode OR opcode = movei_opcode) else -- a makeshift solution to turn a MOVE into an ADD
                    inst_reg_data_out(2 downto 0);
    
    -- write register
    write_reg <= inst_reg_data_out(2 downto 0);

    -- immediate/constant - sign extend
    immediate <=    "000000" & inst_reg_data_out(12 downto 3) when inst_reg_data_out(12) = '0' else
                    "111111" & inst_reg_data_out(12 downto 3);

    -- jump/branch address
    jmp_addr <= (pc_data_out + inst_reg_data_out(6 downto 0)) when (inst_reg_data_out(7) = '1') else --  relative jump
                inst_reg_data_out(6 downto 0); -- absolute jump
    
    -- pc increment logic
    pc_data_in <=   jmp_addr when (opcode = beq_opcode AND z_flag_cmp_data_out = '1')                                   else    -- beq
                    jmp_addr when (opcode = blt_opcode AND (n_flag_cmp_data_out = '0' AND v_flag_cmp_data_out = '1'))   else    -- blt
                    jmp_addr when (opcode = jmp_opcode)                                                                 else    -- jmp
                    pc_data_out + 1;                                                                                            -- next instruction

end architecture;