library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port (
        in_1, in_0  : in    unsigned(15 downto 0);
        sel_op      : in    unsigned(2 downto 0);
        out_0       : out   unsigned(15 downto 0);
        N, Z, C, V  : out   std_logic               -- negative, zero, carry and overflow flags
    );
end entity;

architecture a_alu of alu is
    component mux8x1 is
        port(
            sel                                             : in unsigned(2 downto 0);
            in_7, in_6, in_5, in_4, in_3, in_2, in_1, in_0  : in unsigned(15 downto 0);
            out_0                                           : out unsigned(15 downto 0)
        );
    end component;

    constant ZERO   : unsigned(16 downto 0) := "00000000000000000";
    constant ONE    : unsigned(16 downto 0) := "00000000000000001";

    -- one more bit if carry
    signal add_op, sub_op, and_op, or_op, not_op, eq_cmp, gt_cmp, inc_op, result: unsigned(16 downto 0);

begin
    mux: mux8x1
        port map (
            sel => sel_op,
            in_7 => inc_op  (15 downto 0), -- increment
            in_6 => gt_cmp  (15 downto 0), -- greater than
            in_5 => eq_cmp  (15 downto 0), -- equal to
            in_4 => not_op  (15 downto 0),
            in_3 => or_op   (15 downto 0),
            in_2 => and_op  (15 downto 0),
            in_1 => sub_op  (15 downto 0),
            in_0 => add_op  (15 downto 0),
            out_0 => out_0
        );
    
    result <=   add_op when sel_op = "000" else
                sub_op when sel_op = "001" else
                and_op when sel_op = "010" else
                or_op  when sel_op = "011" else
                not_op when sel_op = "100" else
                eq_cmp when sel_op = "101" else
                gt_cmp when sel_op = "110" else
                inc_op when sel_op = "111" else
                ZERO;
    
    -- operations (sign extension needed)
    add_op  <= ('0' & in_1) + ('0' & in_0);
    sub_op  <= ('0' & in_1) - ('0' & in_0);
    and_op  <= ('0' & in_1) AND ('0' & in_0);
    or_op   <= ('0' & in_1) OR ('0' & in_0);
    not_op  <= NOT ('0' & in_1);
    eq_cmp  <= ONE when in_1 = in_0 else ZERO;
    gt_cmp  <= ONE when in_1 > in_0 else ZERO;
    inc_op  <= ('0' & in_1) + 1;

    -- flags
    N <= '1' when result < ZERO else '0';

    Z <= '1' when -- used in cmp
            ((sel_op /= "101" AND sel_op /= "110") AND (result = ZERO)) OR
            ((sel_op = "101") AND (result = ONE)) OR
            ((sel_op = "110") AND (result = ONE))
        else '0';
    
    C <= '1' when 
            ((sel_op = "000") AND (result(16) = '1')) OR
            ((sel_op = "001") AND (in_0 > in_1))      OR -- borrow
            ((sel_op = "111") AND (result(16) = '1'))
        else '0';

    V <= '1' when
            ((sel_op = "000") AND ((in_1 > ZERO AND in_0 > ZERO AND result < ZERO) OR (in_1 < ZERO AND in_0 < ZERO AND result > ZERO))) OR
            ((sel_op = "001") AND ((in_1 > ZERO AND in_0 < ZERO AND result < ZERO) OR (in_1 < ZERO AND in_0 > ZERO AND result > ZERO))) OR
            ((sel_op = "111") AND (in_1 > ZERO AND result < ZERO))
        else '0';

end architecture;
