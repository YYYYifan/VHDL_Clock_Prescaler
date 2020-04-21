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
    signal prescaler : std_logic_vector (27 downto 0);
    signal clk_2Hz_i : std_logic;
begin
    gen_clk : process (CLK100MHZ, rst)
    begin  -- process gen_clk
        if rst = '1' then
            clk_2Hz_i   <= '0';
            prescaler   <= (others => '0');
        elsif rising_edge(CLK100MHZ) then   -- rising clock edge
            if prescaler = X"2faf080" then     -- 17d7840 <-> 25 000 000 in hex ! we need 50 hz
                prescaler   <= (others => '0');
                clk_2Hz_i   <= not clk_2Hz_i;
            else
                prescaler <= prescaler + "1";
            end if;
        end if;
    end process gen_clk;
      
    LEDS(7 downto 1) <= (others => '0');
    LEDS(0) <= clk_2Hz_i;
end Behavioral;
