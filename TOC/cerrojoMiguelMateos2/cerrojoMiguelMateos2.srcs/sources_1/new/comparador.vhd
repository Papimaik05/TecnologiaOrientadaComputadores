----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2021 11:42:11
-- Design Name: 
-- Module Name: comparador - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparador is
    Port (
     E1 : in STD_LOGIC_VECTOR(7 downto 0);
     E2 : in STD_LOGIC_VECTOR(7 downto 0);
     S : out STD_LOGIC   
    
    );
end comparador;

architecture Behavioral of comparador is

begin
    process(E1,E2)
    begin
    if(E1=E2) then
        S <='1';
    else
        S <='0';
        end if;
    end process;

end Behavioral;
