library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
    generic(N : integer := 16);
    port(clk, reset: in std_logic;
         max: in std_logic_vector(N-1 downto 0);
         y: out std_logic_vector(N-1 downto 0));
end contador;

architecture behavior of contador is
    signal count : unsigned(N-1 downto 0);
begin

    -- converte unsigned para std_logic_vector
    y <= std_logic_vector(count);

    -- lógica do contador
    process(clk)
	 begin
		if rising_edge(clk) then
			if reset = '0' then
					count <= (others => '0');
			elsif count = unsigned(max) then
					count <= (others => '0');
			else
					count <= count + 1;
			end if;
		end if;
	end process;

end behavior;
