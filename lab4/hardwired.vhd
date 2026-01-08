library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library lpm;
use lpm.lpm_components.all;
use work.hardwiredlib.all;
 
entity hardwired is
port( ir               : in std_logic_vector(3 downto 0);
           clock, reset  : in std_logic ;
           z                : in std_logic ;
           mOPs             : out std_logic_vector(26 downto 0));
end hardwired;
architecture arc of hardwired is
 -----Εσωτερίκά σήματα------
 
signal I : std_logic_vector(15 downto 0); ---έξοδοί αποκωδίκοποίήτή εντολών
signal T : std_logic_vector(7 downto 0); ---έξοδοί αποκωδίκοποίήτή καταστάσεων (Τ0-Τ7)
signal cnt : std_logic_vector(2 downto 0); ---μετρήτής καταστάσεων  
signal inc_cnt : std_logic;  ---σήμα ελέγχου μετρήτή
signal clr_cnt : std_logic;  ---σήμα ελέγχου μετρήτή
 -----Βασίκές καταστάσείς FETCH-----
   
signal FETCH1, FETCH2, FETCH3 : std_logic;
 -----Καταστάσείς εντολών-----
 
signal LDAC1, LDAC2, LDAC3, LDAC4, LDAC5 : std_logic;
signal STAC1, STAC2, STAC3, STAC4, STAC5 : std_logic;
signal JUMP1, JUMP2, JUMP3               : std_logic;
begin ---Αποκωδίκοποίήτής εντολών 4-16----
U_DEC_INS : dec4to16
    port map(   Din  => ir,
                Dout => I); -----Απαρίθμήτής καταστάσεων---
U_COUNTER : counter3
    port map( clock => clock,
      rst   => clr_cnt or reset,    -- reset συστήματος  
      inc   => inc_cnt,
      count => cnt ); -----Αποκωδίκοποίήτής καταστάσεων 3-8----
U_DEC_STATE : dec3to8
    port map(  Din  => cnt,
      Dout => T ); ----FETCH κύκλος----
  FETCH1 <= T(0);
  FETCH2 <= T(1);
  FETCH3 <= T(2); ----Καταστάσείς LDAC (πίν.1)----
  LDAC1 <= I(1) and T(3);
  LDAC2 <= I(1) and T(4);
  LDAC3 <= I(1) and T(5);
LDAC4 <= I(1) and T(6);
LDAC5 <= I(1) and T(7); -----Καταστάσείς STACK----
STAC1 <= I(2) and T(3);
STAC2 <= I(2) and T(4);
STAC3 <= I(2) and T(5);
STAC4 <= I(2) and T(6);
STAC5 <= I(2) and T(7); -----Καταστάσείς JUMP---
JUMP1 <= I(12) and T(3);
JUMP2 <= I(12) and T(4);
JUMP3 <= I(12) and T(5); ----Έλεγχος απαρίθμήτή---
clr_cnt <= LDAC5 or STAC5 or JUMP3;
inc_cnt <= not clr_cnt; ----Σήματα ελέγχου(mOPs-πίν.2)----

mOPs(0) <= FETCH1 or FETCH3 or LDAC3 or STAC3;          
mOPs(1) <= LDAC1 or STAC1;                                                      
mOPs(2) <= JUMP3;                                                                        
mOPs(3) <= FETCH2 or LDAC1 or LDAC2 or STAC1;          
mOPs(4) <= FETCH2 or LDAC1 or LDAC2;                              
mOPs(5) <= LDAC2 or STAC2;                                                  
mOPs(6) <= FETCH3;                                                                  -- ARLOAD -- ARINC -- PCLOAD -- PCINC -- DRLOAD -- TRLOAD -- IRLOAD
mOPs(7) <= LDAC5;                                                                   -- ACLOAD
mOPs(8) <= LDAC5;                                                                  
mOPs(9) <= FETCH2 or LDAC1;                                          
mOPs(10) <= STAC5;                                                            
end arc;