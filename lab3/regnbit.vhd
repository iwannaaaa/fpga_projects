library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regnbit is
  generic ( N : integer := 6 );
  port(
    din  : in  std_logic_vector(N-1 downto 0);
    clk  : in  std_logic;
    rst  : in  std_logic;
    ld   : in  std_logic;
    inc  : in  std_logic;
    dout : out std_logic_vector(N-1 downto 0)
  );
end regnbit;

architecture rtl of regnbit is
  signal reg : unsigned(N-1 downto 0);
begin
  process(clk, rst)
  begin
    if rst = '1' then
      reg <= (others => '0');
    elsif rising_edge(clk) then
      if ld = '1' then
        reg <= unsigned(din);
      elsif inc = '1' then
        reg <= reg + 1;
      end if;
    end if;
  end process;

  dout <= std_logic_vector(reg);
end rtl;

