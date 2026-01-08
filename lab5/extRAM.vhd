library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

entity extRAM is
    port(
        clock   : in  std_logic;
        address : in  std_logic_vector(7 downto 0);
        data    : in std_logic_vector(7 downto 0);
        we      : in  std_logic;
        q       : out std_logic_vector(7 downto 0)
    );
end extRAM;

architecture rtl of extRAM is
    signal q_int : std_logic_vector(7 downto 0);
begin
    ram_inst : altsyncram
        generic map (
            operation_mode => "SINGLE_PORT",
            width_a        => 8,
            widthad_a      => 8,
            numwords_a     => 256,
            outdata_reg_a  => "UNREGISTERED",
            init_file      => "extRAM.mif",
            intended_device_family => "MAX 10"
        )
        port map (
            clock0    => clock,
            address_a => address,
            q_a       => q_int,
            wren_a    => we,
            data_a    => data
        );

   
    q    <= q_int;
end rtl;