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
    signal add_op, sub_op, eq_cmp, gt_cmp, result: unsigned(16 downto 0);

begin
    mux: mux4x1
        port map (
            sel => sel_op,
            in_3 => gt_cmp  (15 downto 0), -- greater than
            in_2 => eq_cmp  (15 downto 0), -- equal to
            in_1 => sub_op  (15 downto 0),
            in_0 => add_op  (15 downto 0),
            out_0 => out_0
        );
    
    result <=   add_op when sel_op = "00" else
                sub_op when sel_op = "01" else
                eq_cmp when sel_op = "10" else
                gt_cmp when sel_op = "11" else
                ZERO;
    
    -- operations (sign extension needed)
    add_op  <= ('0' & in_1) + ('0' & in_0);
    sub_op  <= ('0' & in_1) - ('0' & in_0);
    eq_cmp  <= ONE when in_1 = in_0 else ZERO;
    gt_cmp  <= ONE when in_1 > in_0 else ZERO;

    -- flags
    N <= '1' when result < ZERO
        else '0';

    Z <= '1' when -- used in cmp
            ((sel_op /= "10" AND sel_op /= "11") AND (result = ZERO)) OR
            ((sel_op = "10") AND (result = ONE)) OR
            ((sel_op = "11") AND (result = ONE))
        else '0';
    
    C <= '1' when 
            ((sel_op = "00") AND (result(16) = '1')) OR
            ((sel_op = "01") AND (in_0 > in_1))         -- borrow
        else '0';

    V <= '1' when
            ((sel_op = "00") AND ((in_1 > ZERO AND in_0 > ZERO AND result < ZERO) OR (in_1 < ZERO AND in_0 < ZERO AND result > ZERO))) OR
            ((sel_op = "01") AND ((in_1 > ZERO AND in_0 < ZERO AND result < ZERO) OR (in_1 < ZERO AND in_0 > ZERO AND result > ZERO)))
        else '0';

end architecture;
