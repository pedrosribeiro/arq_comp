library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port (
        in_1, in_0  : in    unsigned(15 downto 0);
        sel_op      : in    unsigned(1 downto 0);
        out_0       : out   unsigned(15 downto 0);
        N, Z, C, V  : out   std_logic               -- negative, zero, carry and overflow flags
    );
end entity;

architecture a_alu of alu is
    component mux4x1 is
        port(
            sel                     : in unsigned(1 downto 0);
            in_3, in_2, in_1, in_0  : in unsigned(15 downto 0);
            out_0                   : out unsigned(15 downto 0)
        );
    end component;

    constant ZERO   : unsigned(16 downto 0) := "00000000000000000";
    constant ONE    : unsigned(16 downto 0) := "00000000000000001";

    -- one more bit if carry
    signal add_op, sub_op, cmp_op, result: unsigned(16 downto 0);

begin
    mux: mux4x1
        port map (
            sel => sel_op,
            in_3 => cmp_op  (15 downto 0),
            in_2 => cmp_op  (15 downto 0),
            in_1 => sub_op  (15 downto 0),
            in_0 => add_op  (15 downto 0),
            out_0 => out_0
        );
    
    result <=   add_op when sel_op = "00" else
                sub_op when sel_op = "01" else
                cmp_op when sel_op = "10" else
                ZERO;
    
    -- operations (sign extension needed)
    add_op  <= ('0' & in_1) + ('0' & in_0);
    sub_op  <= ('0' & in_1) - ('0' & in_0);
    cmp_op  <= ('0' & in_1) - ('0' & in_0);

    -- flags
    N <=    '0' when ((sel_op = "10") AND (in_0 > in_1)) else       -- BLT Flag
            '1' when result < ZERO
        else '0';

    Z <= '1' when -- used in cmp
            ((sel_op /= "10") AND (result = ZERO)) OR
            ((sel_op = "10") AND (result = ZERO))                   -- BEQ Flag
        else '0';
    
    C <= '1' when 
            ((sel_op = "00") AND (result(16) = '1')) OR
            ((sel_op = "01" OR sel_op = "10") AND (in_0 > in_1))    -- borrow
        else '0';

    V <= '1' when ((sel_op = "10") AND (in_0 > in_1))               -- BLT Flag
        else '0';

end architecture;
