library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mux is
end tb_mux;

architecture behavior of tb_mux is

    -- Sinais para conectar no DUT (Device Under Test)
    signal input : std_logic_vector(7 downto 0) := (others => '0');
    signal sel   : std_logic_vector(2 downto 0) := (others => '0');
    signal y     : std_logic;

    -- Instancia o componente
    component mux is
        port(
             input: in std_logic_vector(7 downto 0);
             sel: in std_logic_vector(2 downto 0);
             y: out std_logic
        );
    end component;

begin

    -- Instância do MUX
    uut: mux
        port map (
            input => input,
            sel   => sel,
            y     => y
        );

    -- Processo de estímulo
    stimulus_process : process
    begin
        -- Teste: input = "10101010", testar todas as seleções
        input <= "10101010";

        for i in 0 to 7 loop
            sel <= std_logic_vector(to_unsigned(i, 3));
            wait for 20 ns;
        end loop;

        -- Teste com outro valor de entrada
        input <= "11001100";

        for i in 0 to 7 loop
            sel <= std_logic_vector(to_unsigned(i, 3));
            wait for 20 ns;
        end loop;

        -- Finaliza a simulação
        assert false report "Fim da simulação." severity failure;
    end process;

end behavior;
