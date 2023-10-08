library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_proto is
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        debug_out   : out unsigned(16 downto 0)            -- debug rom output
    );
end entity;

architecture a_control_unit_proto of control_unit_proto is
    component pc_7
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(6 downto 0); -- 0 to 127
            data_out: out unsigned(6 downto 0)
        );
    end component;

    signal wr_en_pc                 : std_logic;
    signal data_in_pc, data_out_pc  : unsigned(6 downto 0);

    component rom_128x17
        port (
            clk         : in std_logic;                 -- synchronous rom
            addr        : in unsigned(6 downto 0);      -- 128 addresses
            data_out    : out unsigned(16 downto 0)     -- 17 bits of data
        );
    end component;

    signal addr_rom     : unsigned(6 downto 0);
    signal data_out_rom : unsigned(16 downto 0);

    component state_mach_2
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            state   : out std_logic     -- 2 states
        );
    end component;

    signal state_s: std_logic;

    signal opcode   : unsigned(3 downto 0);
    signal jump_en  : std_logic;
    signal jump_addr: unsigned(6 downto 0);

    -- opcodes
    constant nop_opcode: unsigned(3 downto 0) := "0000";
    constant jmp_opcode: unsigned(3 downto 0) := "1111";

begin
    -- pc instance
    pc: pc_7 port map (
        clk         => clk,
        rst         => rst,
        wr_en       => wr_en_pc,
        data_in     => data_in_pc,
        data_out    => data_out_pc
    );

    -- rom instance
    rom: rom_128x17 port map (
        clk         => clk,
        addr        => addr_rom,
        data_out    => data_out_rom
    );

    -- state machine instance
    state_mach: state_mach_2 port map (
        clk => clk,
        rst => rst,
        state => state_s
    );

    -- pc increment logic
    data_in_pc <=   data_out_pc + 1 when jump_en = '0' else
                    jump_addr;

    -- pc output goes to the rom input (addr)
    addr_rom <= data_out_pc;

    -- debug rom output at the top level
    debug_out <= data_out_rom;

    -- instruction fetch
    wr_en_pc <= '0' when state_s = '0' else     -- fetch
                '1';                            -- decode/execute
    
    -- instruction decode/execute
    opcode <= data_out_rom(16 downto 13);       -- 4 MSB of instruction
    jump_addr <= data_out_rom(6 downto 0);      -- 7 LSB of instruction
    
    jump_en <=  '1' when opcode = jmp_opcode else   -- unconditional jump
                '0';

end architecture;