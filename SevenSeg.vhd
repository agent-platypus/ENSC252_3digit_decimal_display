LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SevenSeg IS 
PORT( D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Y : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
		
end SevenSeg;

ARCHITECTURE Behavior OF SevenSeg IS 
BEGIN
		Y <=  "1000000" WHEN (D = "0000") ELSE
			   "1111001" WHEN (D = "0001") ELSE
				"0100100" WHEN (D = "0010") ELSE
				"0110000" WHEN (D = "0011") ELSE
				"0011001" WHEN (D = "0100") ELSE
				"0010010" WHEN (D = "0101") ELSE
				"0000010" WHEN (D = "0110") ELSE
				"1111000" WHEN (D = "0111") ELSE
				"0000000" WHEN (D = "1000") ELSE
				"0011000" WHEN (D = "1001") ELSE
				"1111111";
				
END Behavior;
