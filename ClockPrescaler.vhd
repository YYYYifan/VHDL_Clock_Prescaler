library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity ClockPrecaler is
    port (
        CLK100MHZ : in  std_logic;        
        RESET_N   : in  std_logic
    );
end ClockPrecaler;

architecture Behavioral of ClockPrecaler is
    signal counter  : std_logic_vector (27 downto 0); -- decimal 50 000 000 in binary is 26 bits
    signal CLK100Hz : std_logic;
begin

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

end Behavioral;
