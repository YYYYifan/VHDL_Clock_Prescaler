<img src="http://chart.googleapis.com/chart?cht=tx&chl= Time = 1 / Frequency" style="border:none;">

firstly, XC7A000T main frequency = 100Mhz = 100,000,000Hz

if we want create 100Hz clock by using 100MHz clock, so the counter limit we need is 1,000,000

<img src="http://chart.googleapis.com/chart?cht=tx&chl= CounterLimit = MainFrequency / 100 = 1000000" style="border:none;">

 we need to use counter limit divided by 2, because there has high-level and low-level in one cycle.

<img src="http://chart.googleapis.com/chart?cht=tx&chl= CounterLimit = CounterLimit / 2 = 1000000/2 = 500000" style="border:none;">

So, its mean when counter is equal to 500000, we change the "CLK100Hz" e.g: high-level -> low-level
5000000 in hex is 7A120, and has 18 bit in binary

#### Code Implement
In './source_code/VLK100Hz.Vhd'
```VHDL
process(CLK100MHZ, RESET_N)
begin
    if RESET_N = '1' then
        CLK100Hz <= '0';
        counter <= (others => '0');     -- clear counter
    elsif rising_edge(CLK100MHZ) then   
        if counter = X"7A120" then      -- 500000 in hex
            counter <= (others => '0');
            CLK100Hz <= not CLK100Hz;
        else
            counter <= counter + "1";
        end if;
    end if;
end process;
```