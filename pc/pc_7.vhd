library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- this pc works as a register
-- the counter itself will be made by incrementing data_out and connecting it to data_in at the top-level
-- the count is given by an external incrementing circuit

entity pc_7 is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        wr_en   : in std_logic;
        data_in : in unsigned(6 downto 0); -- 0 to 127
        data_out: out unsigned(6 downto 0)
    );
end entity;

architecture a_pc_7 of pc_7 is
    signal data: unsigned(6 downto 0);
begin
    process(clk, rst, wr_en)
    begin
        if rst = '1' then
            data <= "0000000";
        elsif wr_en = '1' then
            if rising_edge(clk) then
                data <= data_in;
            end if;
        end if;
    end process;
    data_out <= data;
end architecture;
