LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity d_ff1b is
port(clk1, reset : in std_logic;
			data1 : in std_logic;
		       Q1: out std_logic);
end d_ff1b;

architecture structure of d_ff1b is 
begin
	process(clk1, reset)
		begin 
			if(reset = '1') then
			Q1 <= '0';
			elsif(rising_edge(clk1)) then
			Q1 <= data1;
			end if;
		end process;
end structure;