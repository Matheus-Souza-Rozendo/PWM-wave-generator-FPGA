library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_contador_7bits is
    -- Testbench não tem portas
end tb_contador_7bits;

architecture behavior of tb_contador_7bits is
    -- Sinal de 16 bits para o max e para o contador
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal max     : std_logic_vector(6 downto 0) := "1111111";  -- max = 26 (em decimal)
    signal y       : std_logic_vector(6 downto 0);  -- Saída do contador

    -- Componente contador a ser testado
    component contador is
        generic(N : integer := 16);
        port(
            clk   : in std_logic;
            reset : in std_logic;
            max   : in std_logic_vector(N-1 downto 0);
            y     : out std_logic_vector(N-1 downto 0)
        );
    end component;

begin
    -- Instanciando o componente contador
   uut: contador
    generic map (
        N => 7
    )
    port map (
        clk   => clk,
        reset => reset,
        max   => max,
        y     => y
    );

    -- Gerador de clock
    clk_process : process
    begin
        clk <= not clk;
        wait for 10 ns;  -- Frequência de 50 MHz (tempo de 10ns por ciclo)
    end process;

    -- Sequência de estímulos
    stimulus_process : process
    begin
        -- Iniciar o reset
        reset <= '1';  -- Ativando o reset
        wait for 40 ns;  -- Aguardar 20 ns
        reset <= '0';  -- Desativando o reset
        wait for 10 ns;

        -- Testando a contagem até o valor máximo
        for i in 0 to 130 loop
            wait for 20 ns;  -- Aguardar o próximo ciclo de clock
            -- O contador deve contar de 0 a 26 (máximo = 26)
        end loop;

        -- Testar o reinício após atingir o valor máximo (26)
        wait for 20 ns;
        assert (y = "0000000") report "Erro: O contador não reiniciou corretamente." severity error;

        -- Teste concluído, finalizar simulação
        assert false report "Fim da simulação." severity failure;
    end process;
end behavior;
