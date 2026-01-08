library ieee;
use ieee.std_logic_1164.all;

entity data_bus is
  port(
    -- Είσοδοι δεδομένων από καταχωρητές / μνήμη --
    PCdata  : in  std_logic_vector(7 downto 0);
    DRdata  : in  std_logic_vector(7 downto 0);
    TRdata  : in  std_logic_vector(7 downto 0);
    Rdata   : in  std_logic_vector(7 downto 0);
    ACdata  : in  std_logic_vector(7 downto 0);
    MEMdata : in  std_logic_vector(7 downto 0);

    -- Σήματα ελέγχου buffers --
    PCBUS   : in std_logic;
    DRBUS   : in std_logic;
    TRBUS   : in std_logic;
    RBUS    : in std_logic;
    ACBUS   : in std_logic;
    MEMBUS  : in std_logic;

    -- Έξοδος --
    dataBus : out std_logic_vector(7 downto 0)
  );
end data_bus;


  architecture rtl of data_bus is
begin
  process(PCBUS, DRBUS, TRBUS, RBUS, ACBUS, MEMBUS,
          PCdata, DRdata, TRdata, Rdata, ACdata, MEMdata)
  begin
    -- default
    dataBus <= (others => '0');

    -- priority select (μόνο ένα πρέπει να είναι 1 κάθε φορά)
    if PCBUS = '1' then
      dataBus <= PCdata;
    elsif DRBUS = '1' then
      dataBus <= DRdata;
    elsif TRBUS = '1' then
      dataBus <= TRdata;
    elsif RBUS = '1' then
      dataBus <= Rdata;
    elsif ACBUS = '1' then
      dataBus <= ACdata;
    elsif MEMBUS = '1' then
      dataBus <= MEMdata;
    end if;
  end process;
end rtl;