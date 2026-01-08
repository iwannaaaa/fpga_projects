LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY mseq_rom IS
PORT
(
address : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
clock : IN STD_LOGIC  := '1';
q : OUT STD_LOGIC_VECTOR (35 DOWNTO 0)
);
END mseq_rom;


ARCHITECTURE SYN OF mseq_rom IS

SIGNAL sub_wire0 : STD_LOGIC_VECTOR (35 DOWNTO 0);

BEGIN
q    <= sub_wire0(35 DOWNTO 0);

altsyncram_component : altsyncram
GENERIC MAP (
address_aclr_a => "NONE",
clock_enable_input_a => "BYPASS",
clock_enable_output_a => "BYPASS",
init_file => "rs_microcode.mif",
intended_device_family => "MAX 10",
lpm_hint => "ENABLE_RUNTIME_MOD=NO",
lpm_type => "altsyncram",
numwords_a => 64,
operation_mode => "ROM",
outdata_aclr_a => "NONE",
outdata_reg_a => "CLOCK0",
widthad_a => 6,
width_a => 36,
width_byteena_a => 1
)
PORT MAP (
address_a => address,
clock0 => clock,
q_a => sub_wire0
);



END SYN;
