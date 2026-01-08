library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mseqlib.all;

entity mseq is
  port(
    ir     : in  std_logic_vector(3 downto 0);
    clock  : in  std_logic;
    reset  : in  std_logic;
    z      : in  std_logic;
    code   : out std_logic_vector(35 downto 0);
    mOPs   : out std_logic_vector(26 downto 0)
  );
end mseq;

architecture arc of mseq is
  signal cur_addr  : std_logic_vector(5 downto 0);
  signal next_addr : std_logic_vector(5 downto 0);
  signal addr_rom  : std_logic_vector(5 downto 0);
  signal sel       : std_logic_vector(2 downto 0);
  signal mux_sel   : std_logic_vector(1 downto 0);
  signal rom_code  : std_logic_vector(35 downto 0);
begin

  -- ROM
  mseq_rom_inst : mseq_rom
    port map(
      address => cur_addr,
      q       => rom_code
    );

  code <= rom_code;
  sel  <= rom_code(35 downto 33);
  addr_rom <= rom_code(32 downto 27);
  mOPs <= rom_code(26 downto 0);

  -- SEL logic
  process(sel, z)
  begin
    case sel is
      when "000" => mux_sel <= "00";  -- cur + 1
      when "001" => mux_sel <= "01";  -- addr_rom
      when "010" => mux_sel <= "10";  -- opcode entry
      when "011" =>
        if z = '1' then mux_sel <= "10";
        else            mux_sel <= "00";
        end if;
      when "100" =>
        if z = '0' then mux_sel <= "10";
        else            mux_sel <= "00";
        end if;
      when others =>
        mux_sel <= "00";
    end case;
  end process;

  -- Address MUX
  mux_inst : mux4
    port map(
      sel => mux_sel,
      d0  => std_logic_vector(unsigned(cur_addr) + 1),
      d1  => addr_rom,
      d2  => "00" & ir,
      d3  => (others => '0'),
      y   => next_addr
    );

  -- Address Register
  reg_inst : regnbit
    port map(
      din  => next_addr,
      clk  => clock,
      rst  => reset,
      ld   => '1',
      inc  => '0',
      dout => cur_addr
    );

end arc;
