library ieee;
use ieee.std_logic_1164.all;

entity test_clock is

end test_clock;

architecture behav of test_clock is

component digital_clock is
	port(
		SW : in std_logic_vector(7 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		CLK: in std_logic; --Clock Signal
		LEDR : out std_logic_vector(7 downto 0);
		HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0)
	);
end component;

		-- Declare Signals
		signal SW_i 	: std_logic_vector(7 downto 0) := "00000000";
		signal KEY_i 	: std_logic_vector(3 downto 0):= "1111";
		signal CLK_i 	: std_logic; 
		signal LEDR_i 	: std_logic_vector(7 downto 0) := "00000000";
		signal HEX5_i, HEX4_i, HEX3_i, HEX2_i, HEX1_i, HEX0_i : std_logic_vector(6 downto 0):="0000000";


	begin
		
	 test: digital_clock port map(	 SW 	=> SW_i,
									 KEY 	=> KEY_i,
									 CLK	=> CLK_i,
									 LEDR	=> LEDR_i,
									 HEX5	=> HEX5_i,
									 HEX4	=> HEX4_i, 
									 HEX3	=> HEX3_i, 
									 HEX2	=> HEX2_i, 
									 HEX1	=> HEX1_i, 
									 HEX0	=> HEX0_i 
									 );
									
	-- Generate Clock to Stack the System
	 CLK_i <= not CLK_i after 1000000000 ns;

    end behav;
