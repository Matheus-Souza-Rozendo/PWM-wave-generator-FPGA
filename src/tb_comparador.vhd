library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_comparador is
end tb_comparador;

architecture behavior of tb_comparador is

    -- Sinais de teste
    signal A : std_logic_vector(15 downto 0) := (others => '0');
    signal B : std_logic_vector(15 downto 0) := (others => '0');
    signal y : std_logic;

    -- Componente a ser testado
    component comparador is
        port (
            A : in std_logic_vector(15 downto 0);
            B : in std_logic_vector(15 downto 0);
            y : out std_logic
        );
    end component;

begin

    -- Instância do comparador
    uut: comparador
        port map (
            A => A,
            B => B,
            y => y
        );

    -- Processo de estímulo
    stimulus_process : process
    begin
        -- Teste 1: A < B
        A <= x"0005";  -- 5 em decimal
        B <= x"000A";  -- 10 em decimal
        wait for 20 ns;

        -- Teste 2: A = B
        A <= x"000A";  
        B <= x"000A";
        wait for 20 ns;

        -- Teste 3: A > B
        A <= x"0010";  -- 16 em decimal
        B <= x"000A";  -- 10 em decimal
        wait for 20 ns;

        -- Teste 4: A = 0, B = 0
        A <= x"0000";
        B <= x"0000";
        wait for 20 ns;

        -- Finaliza a simulação
        assert false report "Fim da simulação." severity failure;
    end process;

end behavior;