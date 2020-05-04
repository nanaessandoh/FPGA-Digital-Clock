-- Counter based on 50 MHz clock that outputs control signals 
-- at 2, with synchronous reset and
-- a synchronous clear.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Count2 is
  port( clk, rstb,clr :in std_logic;
  	en, KEY: in std_logic;
  	SW1,SW2 : in std_logic_vector(3 downto 0);
  	cnt2: out std_logic; -- indicates that 2 is showing on the HEX5
        Count : out std_logic_vector(3 downto 0) := "0000"
);
end Count2;

architecture rtl of Count2 is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
  signal hold2: std_logic := '0';
begin

  -- Clock the counter
  process (clk, rstb)
  begin

  if (clk'event) and (clk = '1') then

    if (rstb = '0') then -- synchronous active low reset
      cnt <= "0000";
		hold2 <= '0';
	 elsif (KEY = '0') then	
		hold2 <= '0';
		if (SW1 > "0010" and SW2 >"0011") then
			cnt <= "0010";
		elsif (SW1 > "0010" and SW2 <="0011") then
			cnt <= "0010";
		elsif (SW1 = "0010" and SW2 >"0011") then
			cnt <= SW1;
		elsif (SW1 < "0010" and SW2 >"1001") then
			cnt <= SW1;
		else  
			cnt <= SW1;
		end if;
	 elsif (clr = '1') then 
      cnt <= "0000";
		hold2 <= '0';
	  elsif (cnt = "0010") then
        hold2 <= '1';
      elsif (en = '1') then
          cnt <= cnt + '1';
      else
        cnt <= cnt;
        hold2 <= '0';
        end if;     
      end if;
  end process;
 cnt2<=hold2;
 Count <= cnt;  
  
end rtl;
