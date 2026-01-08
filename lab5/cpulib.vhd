ibrary ieee;
use ieee.std_logic_1164.all;

package cpulib is
---Databus---
component data_bus is
   port(  PCdata  : in  std_logic_vector(7 downto 0);
                DRdata  : in  std_logic_vector(7 downto 0);
                TRdata  : in  std_logic_vector(7 downto 0);
                Rdata   : in  std_logic_vector(7 downto 0);
               ACdata  : in  std_logic_vector(7 downto 0);
              MEMdata : in  std_logic_vector(7 downto 0);
             
               PCBUS   : in std_logic;
               DRBUS   : in std_logic;
               TRBUS   : in std_logic;
               RBUS    : in std_logic;
              ACBUS   : in std_logic;
              MEMBUS  : in std_logic;
             dataBus : out std_logic_vector(7 downto 0) );
         end component;



---Εξωτερική μνήμη RAM 1-PORT---
component extRAM is
    port(  clock   : in  std_logic;
               address : in  std_logic_vector(7 downto 0);
              data    : inout std_logic_vector(7 downto 0);
              q       : out std_logic_vector(7 downto 0);
 we      : in  std_logic);
  end component;
---- ALU -----
component alu is
    port(   a     : in  std_logic_vector(7 downto 0);
                 b     : in  std_logic_vector(7 downto 0);
                alus  : in  std_logic_vector(6 downto 0);
                 y     : out std_logic_vector(7 downto 0);
                z     : out std_logic );
  end component;
---- ALU control ----
component alus is
    port( andop, orop, xorop, notop : in std_logic;
               acinc, aczero, plus, minus : in std_logic;
               alus : out std_logic_vector(6 downto 0));
  end component;

----- Microprogrammed Control Unit από Lab3----
component mseq is
    port( ir     : in  std_logic_vector(3 downto 0);
               clock  : in  std_logic;
               reset  : in  std_logic;
               z      : in  std_logic;
              code   : out std_logic_vector(35 downto 0);
      mOPs   : out std_logic_vector(26 downto 0) );
  end component;
end cpulib;