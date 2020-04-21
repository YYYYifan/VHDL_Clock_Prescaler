# VHDL_Clock_Prescaler
 
My board is NEXYS 4 DDR, main frequency is 100MHz

it works

## THEORY

<img src="http://chart.googleapis.com/chart?cht=tx&chl= Time = 1 / Frequency" style="border:none;">

firstly, our main frequency = 100Mhz = 100 000 000Hz

if we want create 1Hz

<img src="http://chart.googleapis.com/chart?cht=tx&chl= CreateFrequency = MainFrequency / 1 = 100 000 000Hz" style="border:none;">

 we need to use create frequency devide by 2, because there has positive and negative in one cycle.

<img src="http://chart.googleapis.com/chart?cht=tx&chl= HalfFrequency = CreateFrequency / 2 = 100 000 000/2 = 50 000 000" style="border:none;">

So, its mean when prescaler/counter is equal to 50 000 000, we change the "create frequency" e.g: Positive -> Negative

## IMPLEMENT

```VHDL
process
begin  -- process
    if rst = '1' then
        clk_1Hz   <= '0';
        prescaler   <= (others => '0');
    elsif rising_edge(CLK100MHZ) then   -- rising clock edge
        if prescaler = X"2faf080" then     -- 17d7840 <-> 25 000 000 in hex ! we need 50 hz
            prescaler   <= (others => '0');
            clk_1Hz   <= not clk_1Hz;
        else
            prescaler <= prescaler + "1";
        end if;
    end if;
end process ;
```

