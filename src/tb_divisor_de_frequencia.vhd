library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_divisor_de_frequencia is
end tb_divisor_de_frequencia;

architecture behavior of tb_divisor_de_frequencia is

    -- Sinais de teste
    signal clk_in  : std_logic := '0';
    signal reset   : std_logic := '0';
    signal div     : std_logic_vector(2 downto 0) := (others => '0');
    signal clk_out : std_logic;

    -- Componente a ser testado
    component divisor_de_frequencia is
        port(
            clk_in  : in std_logic;
            reset   : in std_logic;
            div     : in std_logic_vector(2 downto 0);
            clk_out : out std_logic
        );
    end component;

begin

    -- Instância do DUT (Device Under Test)
    uut: divisor_de_frequencia
        port map (
            clk_in  => clk_in,
            reset   => reset,
            div     => div,
            clk_out => clk_out
        );

    -- Gerador de clock
    clk_process : process
    begin
        while true loop
            clk_in <= '0';
            wait for 10 ns;
            clk_in <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- Processo de estímulo
    stimulus_process : process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 30 ns;
        reset <= '0';
        wait for 20 ns;

        -- Teste 1: div = "000"
        div <= "000";
        wait for 200 ns;

        -- Teste 2: div = "011"
        div <= "001";
        wait for 200 ns;

        -- Teste 3: div = "111"
        div <= "010";
        wait for 200 ns;

        -- Finaliza a simulação
        assert false report "Fim da simulação." severity failure;
    end process;

end behavior;
