library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity ClockPrecaler is
    port (
        CLK100MHZ : in  std_logic;
        LEDS      : out std_logic_vector(7 downto 0);
        rst       : in  std_logic
    );
end ClockPrecaler;

architecture Behavioral of ClockPrecaler is
    signal prescaler : std_logic_vector (27 downto 0);
    signal clk_1Hz_i : std_logic;
begin
    gen_clk : process (CLK100MHZ, rst)
    begin  -- process gen_clk
        if rst = '1' then
            clk_1Hz_i   <= '0';
            prescaler   <= (others => '0');
        elsif rising_edge(CLK100MHZ) then   
            if prescaler = X"2faf080" then      -- change here to change clock, 5000 00 000 in hex is 2faf080
                prescaler   <= (others => '0');
                clk_1Hz_i   <= not clk_1Hz_i;
            else
                prescaler <= prescaler + "1";
            end if;
        end if;
    end process gen_clk;
      
    LEDS(7 downto 1) <= (others => '0');
    LEDS(0) <= clk_1Hz_i;
end Behavioral;
