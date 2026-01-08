library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.alulib.all;
entity alu is
generic (n : integer := 8);
port (
ac : in std_logic_vector(n-1 downto 0);
db : in std_logic_vector(n-1 downto 0);
alus : in std_logic_vector(7 downto 1);
dout : out std_logic_vector(n-1 downto 0)
);
end alu ;
architecture arch of alu is
signal zeros : std_logic_vector(n-1 downto 0) := (others => '0');
-- λογίκε ς πρα ξείς
signal and_ab, or_ab, xor_ab, notb : std_logic_vector(n-1 downto 0);
-- αρίθμήτίκε ς
signal add_s, sub_s, inc_s : std_logic_vector(n-1 downto 0);
signal add_c, sub_c, inc_c : std_logic;
begin
and_ab <= ac and db;
or_ab <= ac or db;
xor_ab <= ac xor db;
notb <= not db;
adder_add : adder8bit
port map(
a => ac,
b => db,
cin => '0',
s => add_s,
cout=> add_c
);
adder_sub : adder8bit
port map(
a => ac,
b => notb,
cin => '1',
s => sub_s,
cout=> sub_c
);
adder_inc : adder8bit
port map(
a => ac,
b => zeros,
cin => '1',
s => inc_s,
cout=> inc_c
);
process(alus, and_ab, or_ab, xor_ab, notb, add_s, sub_s, inc_s, db, zeros)
begin
case alus is
when "1000000" => dout <= and_ab; -- AND
when "1100000" => dout <= or_ab; -- OR
when "1010000" => dout <= xor_ab; -- XOR
when "1110000" => dout <= notb; -- NOT
when "0000101" => dout <= add_s; -- ADD
when "0001011" => dout <= sub_s; -- SUB
when "0001001" => dout <= inc_s; -- INAC
when "0000100" => dout <= db; -- MOVR
when "0000000" => dout <= zeros; -- CLAC
when "0000110" => dout <= zeros; -- LDAC (ο πως στον πί νακα)
when others => dout <= zeros;
end case;
end process;
end arch;