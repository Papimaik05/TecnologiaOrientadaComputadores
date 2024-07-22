----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2021 19:18:45
-- Design Name: 
-- Module Name: cerrojo - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cerrojo is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           boton : in STD_LOGIC;
           clave : in STD_LOGIC_VECTOR(7 downto 0);
           bloqueado : out STD_LOGIC;
           intentos : out STD_LOGIC_VECTOR(3 downto 0));
end cerrojo;

architecture Behavioral of cerrojo is
    type tipo_estado is (inicial,tres,dos,uno,final);
	signal estadoActual, estadoSiguiente : tipo_estado;
	signal intentoclave : std_logic_vector(7 downto 0);
begin

SYNC:process(clk,rst)
begin
    if rst ='1' then
      estadoActual <= inicial;
    elsif(rising_edge(clk)) then 
      estadoActual <= estadoSiguiente;
    end if;
  end process SYNC;
  
COMB:process(estadoActual,boton)
begin
   
   case estadoActual is
   
   when inicial =>
        
        bloqueado<='1';
        if(boton='1')then estadoSiguiente <=tres;
        intentoclave <= clave;
        else  estadoSiguiente <=inicial;
        end if;
   when tres =>
         intentos <="0011";
         if (boton='1') then
               if(clave=intentoclave) then 
                    estadoSiguiente <=inicial;
                    bloqueado <='1';
               else 
                    estadoSiguiente <= dos;
                    bloqueado<= '0';
            end if;
         end if;
         
 
         
    when dos=>
         intentos <="0001";
         if (boton='1') then
               if(clave=intentoclave) then 
                    estadoSiguiente <=inicial;
                    bloqueado <='1';
               else 
                    estadoSiguiente <= uno;
                    bloqueado<= '0';
            end if;
         end if;
              
    when uno=>
         intentos <="0001";
         if (boton='1') then
               if(clave=intentoclave) then 
                    estadoSiguiente <= inicial;
                    bloqueado <= '1';
               else 
                    estadoSiguiente <= final;
                    bloqueado<= '0';
            end if;
         end if;
         
    when final =>
          intentos <="0000";    
          bloqueado<='0';
     end case;
	end process COMB;        
 end Behavioral;
