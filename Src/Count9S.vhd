-- Counter based on 50 MHz clock that outputs control signals 
-- at 10, with asynchronous reset and
-- a synchronous clear.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Count9S is
  port( clk, rstb, secR: in std_logic; 
  en, KEY: in std_logic;
	SW1,SW2 : in std_logic_vector(3 downto 0);
        cnt9: out std_logic;
        Count : out std_logic_vector(3 downto 0) := "0000"
);
end Count9S;

architecture behav of Count9S is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
begin

  -- Clock the counter
  process (clk, rstb)
  begin
if (clk'event) and (clk = '1') then
    if (rstb = '0') then -- synchronous active low reset
      cnt <= "0000";
	elsif(SecR = '0') then
		cnt <= "0000";
      elsif (KEY = '0') then
	if (SW1 > "0101" and SW2 > "1001") then
		cnt <= "1001";
		elsif (SW1 < "0101" and SW2 > "1001") then
		cnt <= "1001";
		else
		cnt <= SW2;
	end if;
      elsif (en = '1') then
        if (cnt = "1001") then
          cnt9 <= '1';
          cnt <= "0000";
        else
          cnt9 <= '0';
          cnt <= cnt + '1';
        end if;
      else
        cnt <= cnt;
        cnt9 <= '0';
	Count <= cnt;        
      end if;
    end if;
  end process;
  
end behav;
