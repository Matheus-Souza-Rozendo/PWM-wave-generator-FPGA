library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
    port(
         input: in std_logic_vector(7 downto 0);
         sel: in std_logic_vector(2 downto 0);
         y: out std_logic
    );
end mux;

architecture behavior of mux is
begin

    process(input, sel)
    begin
        y <= input(to_integer(unsigned(sel)));
    end process;

end behavior;