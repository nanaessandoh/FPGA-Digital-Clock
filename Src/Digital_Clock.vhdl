library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity digital_clock is
	port(
		SW : in std_logic_vector(7 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		CLK: in std_logic; --Clock Signal
		LEDR : out std_logic_vector(7 downto 0);
		HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0)
	);
end digital_clock;

architecture behav of digital_clock is

	
	-- Ensures the Red LED light up when the Switch is toggled
	component led_input_display
	    port(
        INPUTS :  in std_logic_vector(3 downto 0);
        LED_LIGHTS : out std_logic_vector(3 downto 0)
	    );
	end component;

	-- 1 Second Counter
	component Count1
  	port( clk, rstb, en: in std_logic;
        cnt50M: out std_logic);
	end component;

	-- Counter for SEC0 (HEX0)
	component Count9S is
		port( clk, rstb, secR: in std_logic; 
		en, KEY: in std_logic;
	  SW1,SW2 : in std_logic_vector(3 downto 0);
		  cnt9: out std_logic;
		  Count : out std_logic_vector(3 downto 0) := "0000"
	  );
	  end component;
  
	  -- Counter for SEC1 (HEX1)
	  component Count5s is
		port( clk, rstb, secR :in std_logic;
		en, KEY: in std_logic;
	  SW1,SW2 : in std_logic_vector(3 downto 0);
		  cnt5: out std_logic;
		  Count : out std_logic_vector(3 downto 0) := "0000"
	  );
	  end component;
	
	-- Counter for MIN0 (HEX2)
	component Count9
  port( clk, rstb : in std_logic;
 	 en, KEY: in std_logic;
	SW1,SW2 : in std_logic_vector(3 downto 0);
        cnt9: out std_logic;
        Count : out std_logic_vector(3 downto 0) := "0000"
);
	end component;
	
	-- Counter from MIN1 (HEX3)
	component Count5 is
  port( clk, rstb : in std_logic;
  	en, KEY: in std_logic;
	SW1,SW2 : in std_logic_vector(3 downto 0);
        cnt5: out std_logic;
        Count : out std_logic_vector(3 downto 0) := "0000"
);
	end component;

	-- Counter for HR0(HEX4)
	component Count3 
	  port( clk, rstb: in std_logic; 
  	en, KEY,cnt2: in std_logic;
	SW1,SW2 : in std_logic_vector(3 downto 0);
        cnt10, hex5reset: out std_logic;
        Count : out std_logic_vector(3 downto 0) := "0000"
	);
	end component;

	-- Counter for HR1(HEX5)
	component Count2 is
	  port( clk, rstb,clr :in std_logic;
  	en, KEY: in std_logic;
	SW1,SW2 : in std_logic_vector(3 downto 0);
	cnt2: out std_logic; -- indicates that 2 is showing on the HEX5
        Count : out std_logic_vector(3 downto 0) := "0000"
	);
	end component;

	-- Hex Controllers
	component seven_segment_decoder
	    port(
        SW : in std_logic_vector(3 downto 0);
        HEX0 : out std_logic_vector(6 downto 0)
	    );
	end component;

	-- Signal Declaration
	signal SEC_0, SEC_1, MIN_0, MIN_1, HRS_0, HRS_1 : std_logic_vector(3 downto 0) := "0000"; -- counter output bits for HEX display
	signal Primary1sec, Sec_0_EN, Sec_1_EN, Min_0_EN, Min_1_EN, Hrs_0_EN, Hrs_1_2, H5reset, SecReset1, SecReset2,SecReset3: std_logic := '0';
	signal Load_Bit1, Load_Bit2: std_logic_vector(3 downto 0) := "0000";
	

	begin
	SecReset3 <= KEY(2) and KEY(3); -- Resets the SEC1 and SEC0 when Key 2 or 3 is pressed 


		-- Port Map Declarations
		Second_Generator : Count1 port map (CLK, KEY(0),'1', Primary1sec);
		Second_HEX0 :  Count9s port map (CLK, KEY(0),SecReset3, Primary1sec,'1',"0000", "0000", Sec_0_EN, SEC_0);
		Second_HEX1 :  Count5s port map (CLK, KEY(0),SecReset3, Sec_0_EN,'1',"0000", "0000",Sec_1_EN, SEC_1);
		Minute_HEX2 :  Count9 port map (CLK, KEY(0), Sec_1_EN, KEY(3), SW(7 downto 4), SW(3 downto 0), Min_0_EN, MIN_0);
		Minute_HEX3 :  Count5 port map (CLK, KEY(0), Min_0_EN, KEY(3), SW(7 downto 4), SW(3 downto 0), Min_1_EN, MIN_1);
		Hour_HEX4 :  Count3 port map (CLK, KEY(0), Min_1_EN, KEY(2), Hrs_1_2,SW(7 downto 4), SW(3 downto 0), Hrs_0_EN, H5reset, HRS_0);
		Hour_HEX5 :  Count2 port map (CLK, KEY(0), H5reset, Hrs_0_EN, KEY(2), SW(7 downto 4),SW(3 downto 0), Hrs_1_2, HRS_1);

		LEDs_1 : led_input_display port map (SW(7 downto 4), LEDR(7 downto 4));
		LEDs_0 : led_input_display port map (SW(3 downto 0), LEDR(3 downto 0));

		SecH_0 : seven_segment_decoder port map (SEC_0, HEX0);
		SecH_1 : seven_segment_decoder port map (SEC_1, HEX1);
		MinH_0 : seven_segment_decoder port map (MIN_0, HEX2);
		MinH_1 : seven_segment_decoder port map (MIN_1, HEX3);
		HrsH_0 : seven_segment_decoder port map (HRS_0, HEX4);
		HrsH_1 : seven_segment_decoder port map (HRS_1, HEX5);

end behav;