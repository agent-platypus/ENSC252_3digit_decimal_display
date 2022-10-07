LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY pluscomp IS
generic(data_width: integer);
PORT( QVALUE, INCREM : IN STD_LOGIC_VECTOR(data_width-1 DOWNTO 0);
					  SUM : OUT STD_LOGIC_VECTOR(data_width-1 DOWNTO 0));
					  
END pluscomp;

ARCHITECTURE cheese OF pluscomp IS


BEGIN 

SUM <= QVALUE + INCREM;

END cheese;