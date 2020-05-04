library ieee;
use ieee.std_logic_1164.all;

entity led_input_display is
    port(
        INPUTS :  in std_logic_vector(3 downto 0);
        LED_LIGHTS : out std_logic_vector(3 downto 0)
    );
end led_input_display;

architecture logic of led_input_display is
    begin
        -- LEDR switches on when switch is turned on
	LED_LIGHTS(0) <= INPUTS(0);
	LED_LIGHTS(1) <= INPUTS(1);
	LED_LIGHTS(2) <= INPUTS(2);
	LED_LIGHTS(3) <= INPUTS(3);
    end logic;