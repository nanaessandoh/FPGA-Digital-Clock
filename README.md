# FPGA Design and Implementation of a Digital Clock

The design is prototype on the DE1-SoC board and is driven by the 50 MHz clock signal. 

The clock displays hours, minutes, and seconds on the seven-segment displays.

⋅⋅*  Hours are displayed on HEX5 and HEX4.
⋅⋅*  Minutes are displayed on HEX3 and HEX2.
⋅⋅*  Seconds are displayed on HEX1 and HEX0.
⋅⋅*  The values on the switches are mirrored on the red LEDs to make it easier to see what time you are about to set.
⋅⋅*  The clock displays times from 00:00:00 to 23:59:59, and will roll the digits over properly.
⋅⋅*  KEY(0) will asynchronously reset the clock to 00:00:00.
⋅⋅*  KEY(2) will asynchronously set the hour to the time currently set on switches SW(7 downto 0) and reset the seconds to zero.
⋅⋅*  KEY(3) will asynchronously set the minutes to the time currently set on switches SW(7 downto 0) and reset the seconds to zero.