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
    component pc_7 is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(6 downto 0); -- 0 to 127
            data_out: out unsigned(6 downto 0)
        );
    end component;

    signal wr_en_pc                 : std_logic := '1';     -- always enabled (for testing only)
    signal data_in_pc, data_out_pc  : unsigned(6 downto 0);

    component rom_128x17 is
        port (
            clk         : in std_logic;                 -- synchronous rom
            addr        : in unsigned(6 downto 0);      -- 128 addresses
            data_out    : out unsigned(16 downto 0)     -- 17 bits of data
        );
    end component;

    signal addr_rom     : unsigned(6 downto 0);
    signal data_out_rom : unsigned(16 downto 0);

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

    -- pc increment logic
    data_in_pc <= data_out_pc + 1;

    -- pc output goes to the rom input (addr)
    addr_rom <= data_out_pc;

    -- debug rom output at the top level
    debug_out <= data_out_rom;
    
end architecture;