-- Counter based on 50 MHz clock that outputs control signals 
-- at 6, with synchronous reset and
-- a synchronous clear.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Count5s is
  port( clk, rstb, secR :in std_logic;
  en, KEY: in std_logic;
	SW1,SW2 : in std_logic_vector(3 downto 0);
        cnt5: out std_logic;
        Count : out std_logic_vector(3 downto 0) := "0000"
);
end Count5s;

architecture rtl of Count5s is
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
		cnt <= "0101";
		else
		cnt <= SW1;
	end if;
      elsif (en = '1') then
        if (cnt = "0101") then
          cnt5 <= '1';
          cnt <= "0000";
        else
          cnt5 <= '0';
          cnt <= cnt + '1';
        end if;
      else
        cnt <= cnt;
        cnt5 <= '0';
        Count <= cnt;        
      end if;
    end if;
  end process;
  
end rtl;
