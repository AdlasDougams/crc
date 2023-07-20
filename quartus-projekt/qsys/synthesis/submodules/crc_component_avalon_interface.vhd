LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY crc_component_avalon_interface IS

 PORT (
  clock, resetn, address, wrt, chipselect : IN STD_LOGIC;
  writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
 END crc_component_avalon_interface;

ARCHITECTURE Structure OF crc_component_avalon_interface IS

COMPONENT crc_component_component_vhdl

 PORT (
  clock, resetn, address, wrt : IN STD_LOGIC;
  input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  output: out std_logic_vector(31 downto 0) );
 END COMPONENT;

BEGIN
  crc_instance: crc_component_component_vhdl PORT MAP (clock, resetn, address, wrt, writedata, readdata);
END Structure;