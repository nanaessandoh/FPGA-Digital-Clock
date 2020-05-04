library ieee;
use ieee.std_logic_1164.all;

entity test_clock is

end test_clock;

architecture logic of test_clock is

component digital_clock is
	port(
		SW : in std_logic_vector(7 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		CLK: in std_logic; --Clock Signal
		LEDR : out std_logic_vector(7 downto 0);
		HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0)
	);
end component;

		signal SW :  std_logic_vector(7 downto 0) := "00000000";
		signal KEY : std_logic_vector(3 downto 0):= "1111";
		signal CLK: std_logic; 
		signal LEDR :  std_logic_vector(7 downto 0) := "00000000";
		signal HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : std_logic_vector(6 downto 0):="0000000";


    begin
         test: digital_clock port map(SW,KEY,CLK,LEDR,HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	 CLK <= not CLK after 1000000000 ns;

    end logic;
