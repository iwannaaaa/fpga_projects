library ieee;
use ieee.std_logic_1164.all;
entity adder8bit is
 port(
 a, b : in std_logic_vector(7 downto 0);
 cin : in std_logic;
 s : out std_logic_vector(7 downto 0);
 cout : out std_logic
 );
end adder8bit;
architecture structural of adder8bit is
 component adder1bit is
 port(
 a, b, cin : in std_logic;
 s, cout : out std_logic
 );
 end component;
 signal c : std_logic_vector(8 downto 0);
begin
 c(0) <= cin;
 GEN_ADDERS : for i in 0 to 7 generate
 FA_i: adder1bit
 port map(
 a => a(i),
 b => b(i),
 cin => c(i),
 s => s(i),
 cout => c(i+1)
 );
 end generate GEN_ADDERS;
 cout <= c(8);
end structural;