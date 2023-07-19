LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
 
ENTITY crc_component_project IS
 PORT (
  Clock_50: in std_logic;
  KEY: IN STD_LOGIC_VECTOR(3 downto 0)
 );
END crc_component_project;
 
ARCHITECTURE behavior OF crc_component_project IS

component crc_qsys is
		port (
			clk_clk        : in std_logic := 'X'; -- clk
			reset_reset_n : in std_logic := 'X'  -- reset_n
		);
	end component crc_qsys;
begin
	u0 : component crc_qsys
		port map (
			clk_clk        => Clock_50,        --    clk.clk
			reset_reset_n => Key(0)  -- resetn.reset_n
		);
end behavior;