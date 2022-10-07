LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
Use ieee.std_logic_unsigned;

ENTITY reg_4686 IS 

GENERIC(data_width : INTEGER := 4; 
					  N : INTEGER := 9); 

PORT( clk, reset, inc, ld : IN STD_LOGIC; 
								D : IN UNSIGNED(data_width-1 DOWNTO 0);
								Q : OUT UNSIGNED(data_width-1 DOWNTO 0)); 

END reg_4686;

ARCHITECTURE STRUCTURE OF reg_4686 IS

component equalcomp
generic(data_width: integer);
PORT(NSIZE : IN INTEGER range 0 to 10;
	  QINPUT: IN UNSIGNED(data_width-1 DOWNTO 0);
	  Check : OUT  STD_LOGIC);
end component;

component d_ff
generic(data_width: integer);
port(clk1, reset : in std_logic;
			data1 : in std_logic_vector(data_width-1 downto 0);
		Q1: out std_logic_vector(data_width-1 downto 0));
end component;

component pluscomp
generic(data_width: integer);
PORT( QVALUE, INCREM : IN STD_LOGIC_VECTOR(data_width-1 DOWNTO 0);
					  SUM : OUT STD_LOGIC_VECTOR(data_width-1 DOWNTO 0));
end component;

--end of component list


--output of + component
signal plusout: std_logic_vector(data_width-1 downto 0);

--output of d flipflop at the left of regxxxx
signal Q1out: std_logic_vector(data_width-1 downto 0);

--output of = component
signal Checkout: std_logic;

--output of mux3; right mux
signal mux3output: std_logic_vector(data_width-1 downto 0);

--output of mux2; middle mux
signal mux2output: std_logic_vector(data_width-1 downto 0);

--output of mux1: left mux
signal mux1output: std_logic_vector(data_width-1 downto 0);

--output of and gate
signal and_out: std_logic;

--increment by 1
signal incrone: std_logic_vector(data_width-1 downto 0);


begin

--contains int = 9 and the q output fed back into the = comp
equalcomp1: equalcomp
generic map( data_width => 4)
port map(NSIZE => N, QINPUT => unsigned(Q1out), Check => Checkout);

--contains q output fed back with '1' added
pluscomp1: pluscomp
generic map( data_width => 4)
port map( QVALUE => Q1out, INCREM => incrone, SUM => plusout);

--contains d flipflop with 4 bit input and output
d_ff1: d_ff
generic map( data_width => 4)
port map(clk1 => clk, reset => reset, Q1 => Q1out, data1 => mux3output);

moox3: process(ld, mux2output, D)
	begin
	if ld = '1' then
		mux3output <= std_logic_vector(D);
			elsif ld = '0' then
				mux3output <= mux2output;
					end if;
	end process;
		
moox2: process(and_out, mux1output)
	begin
	if and_out = '1' then
		mux2output <= "0000";
			elsif and_out = '0' then
				mux2output <= mux1output;
					end if;
	end process;
	
moox1: process(inc, Q1out, plusout)
	begin
	if inc = '1' then
		mux1output <= plusout;
			elsif inc = '0' then
				mux1output <= Q1out;
					end if;
	end process;

and_out <= inc and Checkout;
incrone <= "0001";
Q <= unsigned(Q1out);

end STRUCTURE;



