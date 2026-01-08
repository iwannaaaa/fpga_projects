library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
  port(
    sel : in  std_logic_vector(1 downto 0);
    d0  : in  std_logic_vector(5 downto 0);
    d1  : in  std_logic_vector(5 downto 0);
    d2  : in  std_logic_vector(5 downto 0);
    d3  : in  std_logic_vector(5 downto 0);
    y   : out std_logic_vector(5 downto 0)
  );
end mux4;

architecture behavioral of mux4 is
begin
  process(d0, d1, d2, d3, sel)
  begin
    case sel is
      when "00" => y <= d0;
      when "01" => y <= d1;
      when "10" => y <= d2;
      when others => y <= d3;
    end case;
  end process;
end behavioral;
