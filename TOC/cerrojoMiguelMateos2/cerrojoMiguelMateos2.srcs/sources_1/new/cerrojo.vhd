----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2021 11:39:37
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
component registro is
  Port (
    rst  : IN  std_logic;
    clk  : IN  std_logic;
    load : IN  std_logic;
    E    : IN  std_logic_vector(7 downto 0);
    S    : OUT std_logic_vector(7 downto 0)   
  );
end component;
component comparador is
    Port (
     E1 : in STD_LOGIC_VECTOR(7 downto 0);
     E2 : in STD_LOGIC_VECTOR(7 downto 0);
     S : out STD_LOGIC   
    
    );
end component;
signal q,claveacertada :STD_LOGIC;
signal intentoclave : STD_LOGIC_VECTOR(7 downto 0);
begin

reg : registro port map(rst,clk,claveacertada,clave,intentoclave);
comp:comparador port map(clave,intentoclave,q);

SYNC:process(clk,rst)
  begin
  
   if rst ='1' then
      estadoActual <= inicial;
    elsif(rising_edge(clk)) then 
      estadoActual <= estadoSiguiente;
    end if;
  end process SYNC;
  
COMB:process(estadoActual,boton,q)
begin
   
   case estadoActual is
   
   when inicial =>
        
        bloqueado<='1';
        intentos <="0011";
        claveacertada <='1';
        if(boton='1')then 
           estadoSiguiente <=tres;
        else  
        estadoSiguiente <=inicial;
        end if;
   when tres =>
         bloqueado<='0';
         intentos <="0011";
         claveacertada <='0';
         if (boton='1') then
               if(q='1') then 
                    estadoSiguiente <=inicial;
                    
               else 
                    estadoSiguiente <= dos;
                   
            end if;
         else
         estadoSiguiente <=tres;
         end if;
 
         
    when dos=>
         bloqueado<='0';
         intentos <="0010";
         claveacertada <='0';
         
         if (boton='1') then
               if(q='1') then 
                    estadoSiguiente <=inicial;
                    
               else 
                    estadoSiguiente <= uno;
                   
            end if;
         else
         estadoSiguiente <=dos;
         end if;
              
    when uno=>
         bloqueado<='0';
         intentos <="0001";
         claveacertada <='0';
         
         if (boton='1') then
               if(q='1') then 
                    estadoSiguiente <= inicial;
                    
               else 
                    estadoSiguiente <= final;
                    
            end if;
         else
         estadoSiguiente <=uno;
         end if;
         
    when final =>
          bloqueado<='0';
          claveacertada <='0';
          intentos <="0000";
          estadoSiguiente <=final;
     end case;
	end process COMB;        
 end Behavioral;

