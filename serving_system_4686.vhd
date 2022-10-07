LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
Use ieee.std_logic_unsigned.ALL;

ENTITY serving_system_4686 IS 

GENERIC(radix : INTEGER := 9; data_width : INTEGER := 4); 
PORT(clk, reset, take_number : IN STD_LOGIC; 
rollback : IN STD_LOGIC; 
bcd0, bcd1, bcd2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)); 

END serving_system_4686;

architecture structure of serving_system_4686 is

component counter_chain 
GENERIC(radix : INTEGER := 9; data_width : INTEGER := 4); 
PORT(clk, reset, take_number : IN STD_LOGIC; 
						  rollback : IN STD_LOGIC; 
                      number : OUT UNSIGNED((3*data_width)-1 DOWNTO 0)); 
end component;

component SevenSeg
PORT( D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Y : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
end component;

signal MSB, middledigit, firstdigit: std_logic_vector(3 downto 0);

signal tobespliced: unsigned((3*data_width)-1 downto 0);

begin

ccunit: counter_chain
generic map(data_width => data_width)
port map(clk => clk, reset => reset, take_number => take_number, rollback => rollback, number => tobespliced);

leftdigit: SevenSeg
port map(D => MSB, Y => bcd2);

middigit: SevenSeg
port map(D => middledigit, Y => bcd1);

rightdigit: SevenSeg
port map(D => firstdigit, Y => bcd0);

MSB <= std_logic_vector(tobespliced(11 downto 8));

middledigit <= std_logic_vector(tobespliced(7 downto 4));

firstdigit <= std_logic_vector(tobespliced(3 downto 0));

end structure;




