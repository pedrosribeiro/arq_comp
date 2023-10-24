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
            sel_op      : in    unsigned(2 downto 0);
            out_0       : out   unsigned(15 downto 0);
            N, Z, C, V  : out   std_logic               -- negative, zero, carry and overflow flags
        );
    end component;

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

    component pc_7 is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(6 downto 0); -- 0 to 127
            data_out: out unsigned(6 downto 0)
        );
    end component;

    component rom_128x17 is
        port (
            clk         : in std_logic;                 -- synchronous rom
            addr        : in unsigned(6 downto 0);      -- 128 addresses
            data_out    : out unsigned(16 downto 0)     -- 17 bits of data
        );
    end component;

    component control_unit is
        port (
            clk         : in std_logic;
            rst         : in std_logic
        );
    end component;

begin
   
end architecture;