entity lcd is
port(
	clk : in std_logic;
	s,r1,r2,r3,reset:in std_logic;
	g1,g2,g3: out std_logic;
	);
	end lcd;
	
architecture Behavioral of lcd is

type state_type is (T0, T1, T3, T4);
signal current_state, next_state :state_type ;
signal key0,key1,key2,key3 : std_logic; 

------------ Debouncer Initialization ---------
component debouncer
port(
clk :in std_logic;
pb:in std_logic;
reset:in std_logic;
pb_debounced:out std_logic
);
end component
begin

----------- Modules ----------------------------

s0:debouncer
port map (
clk => clk,
PushButton => s,
DebouncedClk=>key0);

s1:debouncer
port map (
clk=>clk,
PushButton=>r1,
DebouncedClk=>key1);

s2:debouncer
port map (
clk=>clk,
PushButton=>r2,
DebouncedClk=>key2);

s3:debouncer
port map (
clk=>clk,
PushButton=>r3,
DebouncedClk=>key3);



------------ Reset Process ---------------------
state_register : process( clk, reset) 
begin
if(reset = '0') then   
current_state <= T0; 
elsif (clk'event and clk = '1') then   
current_State <= next_state;
end if; 
end process;


----------- next state process -----------------
next_state_process : process( s, r1, r2, r3, current_State) 
begin  
	case current_state is  
		when T0 =>
			if (S = '0') then
			next_state <= T0;
			elsif ( S = '1') then 
			next_state <= T1;
			end if;
		when T1 =>
			if (r1 = '1') then
			next_state <= T2;
			elsif (r2 = '1') then
			next_state <= T3;
			elsif (r3 = '1') then
			next_state <= T4;
			else 
			next_state <= T1;
			end if;
		when T2 =>
			if (r1 = '1') then
			next_state <= T2;
			else 
			next_state <= T1;
			end if;
		when T3 =>
			if (r2 = '1') then
			next_state <= T3;
			else 
			next_state <= T1;
			end if;
		when T4 =>
			if (r3 = '1') then
			next_state <= T4;
			else 
			next_state <= T1;
			end if;
	end case; 

end process 


----------- output state process ----------------

output_process : process( clk) 
begin  
if(clk'event and clk = '1') 
then    
case current_state is    
	when T0 =>
		g1 <= '0';
		g2 <= '0';
		g3 <= '0';
	when T1 =>
	   g1 <= '0';
		g2 <= '0';
		g3 <= '0';
	when T2 =>
	   g1 <= '1';
		g2 <= '0';
		g3 <= '0';
	when T3 =>
	   g1 <= '0';
		g2 <= '1';
		g3 <= '0';
	when T4 =>
	   g1 <= '0';
		g2 <= '0';
		g3 <= '1';
	
       
end case;  
end if; 
end process ; 


 
 
end Behavioral;
