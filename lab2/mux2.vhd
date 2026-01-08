library ieee;
use ieee.std_logic_1164.all;
entity mux2 is
 port(
 x0 : in std_logic_vector(7 downto 0);
 x1 : in std_logic_vector(7 downto 0);
 sel : in std_logic;
 y : out std_logic_vector(7 downto 0)
 );
end mux2;
architecture behavioral of mux2 is
begin
 process(x0, x1, sel)
 begin
 if sel = '0' then
 y <= x0;
 else
 y <= x1;
 end if;
 end process;
end behavioral;


