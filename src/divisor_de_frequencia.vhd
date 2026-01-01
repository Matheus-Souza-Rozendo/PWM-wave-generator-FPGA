library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_de_frequencia is
    port(
        clk_in  : in std_logic;
        reset   : in std_logic;
        div     : in std_logic_vector(2 downto 0);
        clk_out : out std_logic
    );
end divisor_de_frequencia;

architecture behavior of divisor_de_frequencia is

    -- Declaração dos componentes dentro da arquitetura
    component mux is
        port (
            input : in std_logic_vector(7 downto 0);
            sel   : in std_logic_vector(2 downto 0);
            y     : out std_logic
        );
    end component;

    component contador is
        generic(N : integer := 16);
        port(
            clk   : in std_logic;
            reset : in std_logic;
            max   : in std_logic_vector(N-1 downto 0);
            y     : out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- Sinais internos
    signal y_contador : std_logic_vector(6 downto 0);
    signal max        : std_logic_vector(6 downto 0) := "1111111";
    signal input_mux  : std_logic_vector(7 downto 0);

begin

    -- Concatenação dos sinais
    input_mux <= y_contador & clk_in;

    -- Instância do contador
    C : contador
        generic map (
            N => 7
        )
        port map (
            clk   => clk_in,
            reset => reset,
            max   => max,
            y     => y_contador
        );

    -- Instância do mux
    M : mux
        port map (
            input => input_mux,
            sel   => div,
            y     => clk_out
        );

end behavior;
