library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparador is
    port (
        A      : in std_logic_vector(15 downto 0);  
        B      : in std_logic_vector(15 downto 0);  
        y : out std_logic                   -- Resultado da comparação
    );
end comparador;

architecture behavior of comparador is
begin
    process(A, B)
    begin
            if unsigned(A) < unsigned(B) then
            y <= '1'; 
        else
            y <= '0';  
        end if;
    end process;
end behavior;
