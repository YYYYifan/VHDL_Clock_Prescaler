# VHDL_Clock_Prescaler
 
My board is NEXYS 4 DDR, main frequency is 100MHz

it works

## THEORY

<img src="http://chart.googleapis.com/chart?cht=tx&chl= Time = 1 / Frequency" style="border:none;">

firstly, our main frequency = 100Mhz = 100 000 000Hz

if we want create 1Hz

<img src="http://chart.googleapis.com/chart?cht=tx&chl= CreateFrequency = MainFrequency / 1 = 100 000 000Hz" style="border:none;">

 we need to use create frequency devide by 2, because there has positive and negative in one cycle.

<img src="http://chart.googleapis.com/chart?cht=tx&chl= HalfFrequency = CreateFrequency / 2 = 100 000 000/2 = 50 000 000Hz" style="border:none;">

So, its mean when prescaler/counter is equal to 50 000 000, we change the "create frequency" e.g: Positive -> Negative

## IMPLEMENT

```VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity main is
    port (
        CLK100MHZ : in  std_logic;
        LEDS      : out std_logic_vector(7 downto 0);
        rst       : in  std_logic
    );
end main;

architecture Behavioral of main is
    signal prescaler : std_logic_vector (25 downto 0); -- 50 000 000 in binary have 26 bits
    signal clk_1Hz : std_logic;
begin
    process (CLK100MHZ, rst)
    begin
        if rst = '1' then
            clk_1Hz   <= '0';
            prescaler   <= (others => '0');
        elsif rising_edge(CLK100MHZ) then   
            if prescaler = X"2faf080" then     -- 2faf080 <-> 50 000 000 in hex
                prescaler   <= (others => '0');
                clk_1Hz   <= not clk_1Hz;
            else
                prescaler <= prescaler + "1";
            end if;
        end if;
    end process;
      
    LEDS(7 downto 1) <= (others => '0');
    LEDS(0) <= clk_1Hz;
end Behavioral;

```

