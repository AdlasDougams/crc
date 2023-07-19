
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY crc_component_component_vhdl IS
  PORT (
    clock, resetn, address, wrt : IN STD_LOGIC;
    input : IN STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    output : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0')
  );
END crc_component_component_vhdl;

ARCHITECTURE behavior OF crc_component_component_vhdl IS

  -- counter --
  SIGNAL int_index : INTEGER RANGE -1 TO 23 := 23;

  -- enable bit -- (last bit of generator register but stored seperately)
  SIGNAL enable : STD_LOGIC := '0';

  -- registers --
  SIGNAL message : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL generator : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

  output <= message;

  PROCESS (clock, resetn) IS

  BEGIN
  -- reset doesn't listen on the clock uptick --
    IF (resetn = '0') THEN

      message <= (OTHERS => '0');
      generator <= (OTHERS => '0');
      int_index <= 23;

    ELSIF rising_edge(clock) THEN

      IF (wrt = '1') THEN
        IF (address = '0') THEN
          message(31 DOWNTO 0) <= input(31 DOWNTO 0);
        ELSIF (address = '1') THEN
          generator(31 DOWNTO 0) <= input(31 DOWNTO 1) & '0';
          enable <= input(0);
        END IF;
      ELSIF enable = '1' THEN
        IF int_index = 0 THEN
          enable <= '0';
        ELSIF message(31) = '1' THEN
          message <= message XOR generator;
        ELSE
          message <= message(30 DOWNTO 0) & '0';
          int_index <= int_index - 1;
        END IF;
      END IF;
    END IF;
  END PROCESS;
END behavior;