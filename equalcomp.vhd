LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY equalcomp IS
generic(data_width: integer:= 4);
PORT(NSIZE : IN INTEGER range 0 to 10;
	  QINPUT: IN UNSIGNED(data_width-1 DOWNTO 0);
	  Check : OUT  STD_LOGIC);
	  
END equalcomp;

ARCHITECTURE STRUCTURE of equalcomp IS
BEGIN

PROCESS(NSIZE, QINPUT)
BEGIN
	IF NSIZE = to_integer(QINPUT) THEN
		Check <= '1';
		
	ELSIF NSIZE /= to_integer(QINPUT) THEN
		Check <= '0';
		
	end if;

	end process;

END STRUCTURE;