library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_mach_3 is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        state   : out unsigned(1 downto 0)
    );
end entity;

architecture a_state_mach_3 of state_mach_3 is
    signal state_s: unsigned(1 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state_s <= "00";
        elsif rising_edge(clk) then
            if state_s = "10" then      -- if last state, returns to first
                state_s <= "00";
            else
                state_s <= state_s + 1; -- else, move on
            end if;
        end if;
    end process;
    state <= state_s;
end architecture;
