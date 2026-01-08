library ieee;
use ieee.std_logic_1164.all;
entity dec4to16 is
port(
Din  : in  std_logic_vector(3 downto 0);
Dout : out std_logic_vector(15 downto 0)
);
end dec4to16;
architecture rtl of dec4to16 is
begin
process(Din)
begin
Dout <= (others => '0');
case Din is
when "0000" => Dout(0)  <= '1';
when "0001" => Dout(1)  <= '1';
when "0010" => Dout(2)  <= '1';
when "0011" => Dout(3)  <= '1';
when "0100" => Dout(4)  <= '1';
when "0101" => Dout(5)  <= '1';
when "0110" => Dout(6)  <= '1';
when "0111" => Dout(7)  <= '1';
when "1000" => Dout(8)  <= '1';
when "1001" => Dout(9)  <= '1';
when "1010" => Dout(10) <= '1';
when "1011" => Dout(11) <= '1';
when "1100" => Dout(12) <= '1';
when "1101" => Dout(13) <= '1';
when "1110" => Dout(14) <= '1';
when others => Dout(15) <= '1';
end case;
end process;
end rtl;