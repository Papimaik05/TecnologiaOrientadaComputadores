library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity mult8b is
port(
X : in std_logic_vector(3 downto 0);
Y : in std_logic_vector(3 downto 0);
Z : out std_logic_vector(7 downto 0)
);
end mult8b;

architecture Behavioral of mult8b is

component sumador is PORT(
 A : IN   std_logic_vector(7 downto 0);
 B : IN   std_logic_vector(7 downto 0);
 C : OUT  std_logic_vector(7 downto 0)
);

end component;

signal entrada,entrada2,entrada3,entrada4,s1,s2,salida_final: std_logic_vector(7 downto 0);
signal Xy0,Xy1,Xy2,Xy3:std_logic_vector(3 downto 0);
begin

Xy0<=X AND ("000"& Y(0 downto 0));
Xy1<=X AND ("00"&Y(1 downto 1)&"0");
Xy2<=X AND ("0"&Y(2 downto 2)&"00");
Xy3<=X AND (Y(3 downto 3)&"000");

entrada<="0000" & Xy0;
entrada2<="000" & Xy1 & "0";
entrada3<="00" & Xy2 & "00";
entrada4<="0" & Xy3 & "000";

sum1: sumador PORT MAP(entrada2,entrada,s1);
sum2: sumador PORT MAP(entrada3,s1,s2);
sum3: sumador PORT MAP(entrada4,s2,salida_final);
z<=salida_final;

end Behavioral;