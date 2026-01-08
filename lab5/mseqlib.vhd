library ieee;
use ieee.std_logic_1164.all;
package mseqlib is
component regnbit is
port(din : in std_logic_vector(5 downto 0);
clk,rst,ld : in std_logic;
inc : in std_logic;
dout : out std_logic_vector(5 downto 0));
end component;
component mux4 is
port( d0 : in std_logic_vector(5 downto 0);
d1 : in std_logic_vector(5 downto 0);
d2 : in std_logic_vector(5 downto 0);
d3 : in std_logic_vector(5 downto 0);
sel : in std_logic_vector(1 downto 0);
y : out std_logic_vector(5 downto 0));
end component;
component mseq_rom is  
port( address: in std_logic_vector(5 downto 0);
q : out std_logic_vector(35 downto 0));
end component;
end package mseqlib;
 package body mseqlib is
 end package body mseqlib;