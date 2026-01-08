library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;      
entity counter3 is
port( clock : in  std_logic;                  
rst   : in  std_logic;                  
inc   : in  std_logic;                  -- reset (επίστροφή  στο T0) -- αυ ξήσή κατα  1
count : out std_logic_vector(2 downto 0)  -- τρε χουσα κατα στασή (T0–T7) );
);
end counter3 ;
architecture rtl of counter3 is
signal cnt : std_logic_vector(2 downto 0);   -- εσωτερίκο ς μετρήτή ς
begin
process(clock)
begin
if rising_edge(clock) then ---- Αν rst = 1 →μήδε νίσε τον μετρήτή  (πή γαίνε στο T0)----
if rst = '1' then
cnt <= "000"; ---- αν inc = 1 → αυ ξήσε κατα  1----
elsif inc = '1' then
cnt <= cnt + 1; ---- κρα τα τήν ί δία τίμή ----
else
cnt <= cnt;
end if;
end if;
end process; ---- Συ νδεσή εσωτερίκου  μετρήτή  με τήν ε ξοδο---
count <= cnt;
end rtl;
