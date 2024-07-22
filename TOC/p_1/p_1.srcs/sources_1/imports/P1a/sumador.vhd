library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sumador is
  Port (
    A : IN   std_logic_vector(3 downto 0);
    B : IN   std_logic_vector(3 downto 0);
    C : OUT  std_logic_vector(3 downto 0)   
  );
end sumador;

architecture rt1 of sumador is

begin

  C <= A + B;

end rt1;
