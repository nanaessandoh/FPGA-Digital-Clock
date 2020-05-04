-- Counter based on 50 MHz clock that outputs control signals 
-- at 10, with asynchronous reset and
-- a synchronous clear.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Count3 is
  port( clk, rstb: in std_logic; 
  	en, KEY,cnt2: in std_logic;
	SW1,SW2 : in std_logic_vector(3 downto 0);
        cnt10,hex5reset: out std_logic;
        Count : out std_logic_vector(3 downto 0) := "0000"
);
end Count3;

architecture rtl of Count3 is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
  signal H5reset, hold10: std_logic := '0';	
begin

  -- Clock the counter
  process (clk, rstb)
  begin

   if (clk'event) and (clk = '1') then
    if (cnt2 = '1' and cnt = "0100") then --sends a signal to reset HEX5 at 23:59:59
	  H5reset <= '1';
	  cnt <= "0000";
    elsif (rstb = '0') then -- synchronous active low reset
      cnt <= "0000";
		H5reset <= '0';
      elsif (KEY = '0') then
		H5reset <= '0';
	if (SW1 > "0010" and SW2 >"0011") then
		cnt <= "0011";
	elsif (SW1 > "0010" and SW2 <="0011") then
		cnt <= SW2;
	elsif (SW1 = "0010" and SW2 >"0011") then
		cnt <= "0011";
	elsif (SW1 < "0010" and SW2 >"1001") then
		cnt <= "1001";
	else  
	     cnt <= SW2;
	end if;
      elsif (en = '1') then
        if (cnt = "1001") then
		hold10 <= '1';
		H5reset <= '0';
          cnt <= "0000";
        else
	  hold10 <= '0';
	  H5reset <= '0';
          cnt <= cnt + '1';
        end if;
      else
	hold10 <= '0';
        cnt <= cnt;
	H5reset <= H5reset;                
      end if;
    end if;
  end process;
  Count <= cnt;
  cnt10 <= hold10;
  hex5reset <= H5reset;
  	
 
end rtl;
