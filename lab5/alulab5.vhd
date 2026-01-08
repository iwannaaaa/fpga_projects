library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
  port(
    a     : in  std_logic_vector(7 downto 0);  -- AC
    b     : in  std_logic_vector(7 downto 0);  -- dataBus
    alus  : in  std_logic_vector(6 downto 0);  -- control από alus
    y     : out std_logic_vector(7 downto 0);  -- αποτέλεσμα
    z     : out std_logic                     -- zero flag
  );
end alu;

architecture rtl of alu is
  signal result : std_logic_vector(7 downto 0);
begin

  process(a, b, alus)
  begin
    -- default
    result <= (others => '0');

    -- ALU operations 
    if alus(0) = '1' then              -- AND
      result <= a and b;

    elsif alus(1) = '1' then           -- OR
      result <= a or b;

    elsif alus(2) = '1' then           -- XOR
      result <= a xor b;

    elsif alus(3) = '1' then           -- NOT
      result <= not a;

    elsif alus(4) = '1' then           -- AC + 1
      result <= a + 1;

    elsif alus(5) = '1' then           -- ADD
      result <= a + b;

    elsif alus(6) = '1' then           -- SUB
      result <= a - b;

    else
      result <= a;                     -- default: passthrough
    end if;
  end process;

  -- Outputs
  y <= result;

  -- Zero flag
  z <= '1' when result = "00000000" else '0';

end rtl;