LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
Use ieee.std_logic_unsigned.ALL;

ENTITY counter_chain IS 

GENERIC(radix : INTEGER := 9; data_width : INTEGER := 4); 
PORT(clk, reset, take_number : IN STD_LOGIC; 
						  rollback : IN STD_LOGIC; 
                      number : OUT UNSIGNED((3*data_width)-1 DOWNTO 0)); 
END counter_chain;

architecture structure of counter_chain is

--icunit
component increment_control_unit 

GENERIC(N : INTEGER := 9; data_width : INTEGER := 4);
PORT(clk, reset : IN STD_LOGIC;
incr, rollback : IN STD_LOGIC; --generates next number, rollback decrements
flag, flag_back : OUT STD_LOGIC;
q : OUT UNSIGNED(data_width-1 DOWNTO 0)); --output value

end component;

--equal comp 
component equalcomp

generic(data_width: integer:= 4);
PORT(NSIZE : IN INTEGER range 0 to 10;
	  QINPUT: IN UNSIGNED(data_width-1 DOWNTO 0);
	  Check : OUT  STD_LOGIC);
	  
end component;

--end of component list

--connections between the icunit components
signal ic1flag: std_logic;

--stored number in each icunit
signal ic1q, ic2q, ic3q: unsigned(data_width-1 downto 0);

--full concatenated number
signal concat: unsigned((3*data_width)-1 downto 0);

signal clockall: std_logic;

signal eqout: std_logic;

signal and1: std_logic;

signal zeroint: integer:= 0;

signal mux2: std_logic;

signal ic2and: std_logic;

signal eqout1, eqout3: std_logic;

signal rollbacksig, takenumbersig: std_logic;

signal eq4checksig: std_logic;

signal rb2and: std_logic;

signal rb3and: std_logic;

signal inc2and: std_logic;

signal eqout5: std_logic;


begin 

ic1: increment_control_unit
generic map(N => 9, data_width => 4)
port map(incr => takenumbersig, rollback => rollbacksig, clk => clockall, reset => mux2,
			flag => ic1flag, flag_back => open, q => ic1q);
			
ic2: increment_control_unit
generic map(N => 9, data_width => 4)
port map(incr => inc2and, rollback => rb2and, clk => clockall, reset => mux2,
			flag => open, flag_back => open, q => ic2q);
			
ic3: increment_control_unit
generic map(N => 9, data_width => 4)
port map(incr => ic2and, rollback => rb3and, clk => clockall, reset => mux2,
			flag => open, flag_back => open, q => ic3q);
			
zerosequal: equalcomp
generic map(data_width => (3*data_width))
port map(NSIZE => zeroint, QINPUT => concat, Check => eqout);

nineequal1: equalcomp
generic map(data_width => data_width)
port map(NSIZE => radix, QINPUT => ic2q, Check => eqout1);

nineequal3: equalcomp
generic map(data_width => data_width)
port map(NSIZE => radix, QINPUT => ic1q, CHeck => eqout3);

zerosequal2: equalcomp
generic map(data_width => data_width)
port map( NSIZE => zeroint, QINPUT => ic1q, Check => eq4checksig);

zerosequal3: equalcomp
generic map(data_width => data_width)
port map( NSIZE => zeroint,QINPUT => ic2q, Check => eqout5);
	
moox2: process(and1, reset, mux2)
begin
	if and1 = '1' then
	mux2 <= '1';
	else 
	mux2 <= reset;
	end if;
	end process;
	
and1 <= eqout and rollbacksig;

concat <= ic3q & ic2q & ic1q;	

number <= concat;

ic2and <= eqout1 and eqout3 and takenumbersig;

clockall <= clk;

rollbacksig <= rollback;

takenumbersig <= take_number;

rb2and <= eq4checksig and rollbacksig;

inc2and <= ic1flag and takenumbersig;

rb3and <= eqout5 and rb2and;

end structure;		


