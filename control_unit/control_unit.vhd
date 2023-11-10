library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
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
end entity;

architecture a_control_unit of control_unit is

    component state_mach_3
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            state   : out unsigned(1 downto 0)
        );
    end component;

    signal state_s: unsigned(1 downto 0);

    signal opcode   : unsigned(3 downto 0);

    -- opcodes
    constant add_opcode     : unsigned(3 downto 0) := "0001";
    constant sub_opcode     : unsigned(3 downto 0) := "0010";
    constant movei_opcode   : unsigned(3 downto 0) := "0011";
    constant move_opcode    : unsigned(3 downto 0) := "0100";
    constant cmp_opcode     : unsigned(3 downto 0) := "0101";
    constant beq_opcode     : unsigned(3 downto 0) := "0110";
    constant blt_opcode     : unsigned(3 downto 0) := "0111";
    constant jmp_opcode     : unsigned(3 downto 0) := "1111";

    -- states
    constant fetch_s    : unsigned(1 downto 0) := "00";
    constant decode_s   : unsigned(1 downto 0) := "01";
    constant exec_s     : unsigned(1 downto 0) := "10";

begin
    -- state machine instance
    state_mach: state_mach_3 port map (
        clk     => clk,
        rst     => rst,
        state   => state_s
    );

    -- instruction fetch ---------------------------------------------------
    wr_en_pc <= '1' when state_s = exec_s else
                '0';

    -- instruction decode --------------------------------------------------
    wr_en_inst_reg <=   '1' when state_s = decode_s else
                        '0';

    opcode <= instruction(16 downto 13);                -- 4 MSB of instruction

    alu_op <=   "00" when opcode = add_opcode else
                "01" when opcode = sub_opcode else
                "10" when opcode = cmp_opcode else
                "00";
    
    -- instruction execute --------------------------------------------------
    alu_src <=  '1' when opcode = movei_opcode else     -- loading a constant
                '0';
    
    -- flags write enable
    flags_wr_en <=  '1' when state_s = exec_s AND 
                    (
                        opcode = cmp_opcode OR
                        opcode = add_opcode OR
                        opcode = sub_opcode
                    ) else '0';

    -- to do: enable jump when BEQ and BLT
    jump_en <=  '1' when opcode = jmp_opcode else       -- unconditional jump
                '0';
    
    reg_write <= '1' when state_s = exec_s AND          -- instructions writing to registers
                (
                    opcode = add_opcode     OR
                    opcode = sub_opcode     OR
                    opcode = movei_opcode   OR
                    opcode = move_opcode
                ) else '0';

end architecture;