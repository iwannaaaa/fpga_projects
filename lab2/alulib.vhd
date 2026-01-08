library ieee;
use ieee.std_logic_1164.all;
package alulib is
 component adder1bit is
 port(
 a : in std_logic;
 b : in std_logic;
 cin : in std_logic;
 s : out std_logic;
 cout : out std_logic
 );
 end component;
 component adder8bit is
 port(
 a : in std_logic_vector(7 downto 0);
 b : in std_logic_vector(7 downto 0);
 cin : in std_logic;
 s : out std_logic_vector(7 downto 0);
 cout : out std_logic
 );
 end component;
 component mux2 is
 port(
 x0 : in std_logic_vector(7 downto 0);
 x1 : in std_logic_vector(7 downto 0);
 sel : in std_logic;
 y : out std_logic_vector(7 downto 0)
 );
 end component;
 component mux4 is
 port(
 d0 : in std_logic_vector(7 downto 0);
 d1 : in std_logic_vector(7 downto 0);
 d2 : in std_logic_vector(7 downto 0);
 d3 : in std_logic_vector(7 downto 0);
 sel : in std_logic_vector(1 downto 0);
 y : out std_logic_vector(7 downto 0)
 );
 end component;
end package alulib;
