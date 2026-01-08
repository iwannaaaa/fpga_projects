library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.cpulib.all;

entity rs_cpu is
port(ARdata,PCdata  : out std_logic_vector(15 downto 0);
     DRdata,ACdata  : out std_logic_vector(7 downto 0);
     IRdata,TRdata  : out std_logic_vector(7 downto 0);
     RRdata         : out std_logic_vector(7 downto 0);
     ZRdata         : out std_logic ;
     clock,reset    : in std_logic;
     mOP            : buffer std_logic_vector(26 downto 0);
     addressBus     : out std_logic_vector(15 downto 0);
     dataBus        : inout std_logic_vector(7 downto 0));
end rs_cpu ;

architecture arc of rs_cpu is
-- Registers –
signal AR_reg : std_logic_vector(15 downto 0);
signal PC : std_logic_vector(15 downto 0);
signal DR, IR, AC, TR, R : std_logic_vector(7 downto 0);
signal Z : std_logic;
--DATABUS---
signal dataBus_int : std_logic_vector(7 downto 0);
-- ALU --
signal alu_out : std_logic_vector(7 downto 0);
signal alu_z   : std_logic;
signal alus_sig    : std_logic_vector(6 downto 0);

-- Memory --
signal mem_data : std_logic_vector(7 downto 0);

-- Control --
signal code : std_logic_vector(35 downto 0);

begin
U_CTRL : mseq
  port map( ir => IR(3 downto 0),
            clock => clock,
            reset => reset,
            z => Z,
            code => code,
           mOPs => mOP);
U_ALUS : alus
  port map(
    andop  => mOP(18),
    orop   => mOP(19),
    xorop  => mOP(20),
    notop  => mOP(21),
    acinc  => mOP(22),
    aczero => mOP(23),
    plus   => mOP(24),
    minus  => mOP(25),
    alus   => alus_sig
  );

U_ALU : alu
  port map(
    a    => AC,
    b    => dataBus_int,
    alus => alus_sig,
    y    => alu_out,
    z    => alu_z
  );
U_RAM : extRAM
  port map( clock => clock,
           address => AR_reg(7 downto 0),
           data => dataBus_int,
           we => mOP(10),
 q => mem_data);
U_BUS : data_bus
  port map(
    PCdata => PC(7 downto 0),
    DRdata => DR,
    TRdata => TR,
    Rdata  => R,
    ACdata => AC,
    MEMdata => mem_data,

    PCBUS  => mOP(11),
    DRBUS  => mOP(12),
    TRBUS  => mOP(13),
    RBUS   => mOP(14),
    ACBUS  => mOP(15),
    MEMBUS => mOP(16),

    dataBus => dataBus_int
  );

process(clock)
begin
  if rising_edge(clock) then
    if reset='1' then
      AR_reg <= (others=>'0');
      PC <= (others=>'0');
      DR <= (others=>'0');
      IR <= (others=>'0');
      AC <= (others=>'0');
      TR <= (others=>'0');
      R  <= (others=>'0');
      Z  <= '0';
    else
       if mOP(0)='1' then AR_reg <= x"00" & dataBus_int;
      elsif mOP(1)='1' then AR_reg <= AR_reg + 1; end if;
      if mOP(2)='1' then PC <= x"00" & dataBus_int; end if;
      if mOP(3)='1' then PC <= PC + 1; end if;
      if mOP(4)='1' then DR <= dataBus_int; end if;
      if mOP(6)='1' then IR <= dataBus_int; end if;
      if mOP(7)='1' then AC <= alu_out; end if;
      if mOP(8)='1' then Z  <= alu_z; end if;
      if mOP(5)='1' then TR <= dataBus_int; end if;
      if mOP(9)='1' then R  <= dataBus_int; end if;
    end if;
  end if;
end process;
----- Έξοδοι waveforms ----
ARdata     <= AR_reg;
PCdata     <= PC;
DRdata     <= DR;
IRdata     <= IR;
ACdata     <= AC;
TRdata     <= TR;
RRdata     <= R;
ZRdata     <= Z;

addressBus <= AR_reg;
dataBus <= dataBus_int;
   
end arc;
