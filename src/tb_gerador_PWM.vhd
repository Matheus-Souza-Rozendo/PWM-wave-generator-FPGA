library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_gerador_PWM is
end tb_gerador_PWM;

architecture behavior of tb_gerador_PWM is

    -- Sinais de teste
    signal D      : std_logic_vector(15 downto 0) := (others => '0');
    signal max    : std_logic_vector(15 downto 0) := (others => '0');
    signal clk_in : std_logic := '0';
    signal reset  : std_logic := '0';
    signal div    : std_logic_vector(2 downto 0) := (others => '0');
    signal ypwm   : std_logic;

    -- Componente a ser testado
    component gerador_PWM is
        port (
            D      : in std_logic_vector(15 downto 0);
            max    : in std_logic_vector(15 downto 0);
            clk_in : in std_logic;
            reset  : in std_logic;
            div    : in std_logic_vector(2 downto 0);
            ypwm   : out std_logic
        );
    end component;

begin

    -- Instância do DUT (Device Under Test)
    uut: gerador_PWM
        port map (
            D      => D,
            max    => max,
            clk_in => clk_in,
            reset  => reset,
            div    => div,
            ypwm   => ypwm
        );

    -- Processo de geração de clock
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
    -- Aplica o reset
    reset <= '1';
    wait for 50 ns;
    reset <= '0';
    wait for 50 ns;

    -- Configura divisor de frequência e valor máximo
    div <= "000";
    max <= "0001001110001111";

    -- Teste 1: Pulso PWM com D = 2 (50% duty cycle)
    D <= "0000011111101000";
    wait for 400 us;


    -- Finaliza a simulação
    assert false report "Fim da simulação." severity failure;
end process;

end behavior;
