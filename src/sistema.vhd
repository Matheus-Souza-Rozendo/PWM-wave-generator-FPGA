library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sistema is
    port (
        CLOCK_50 : in  std_logic;
        KEY      : in  std_logic_vector(3 downto 0);
        GPIO    : out std_logic_vector(35 downto 0)
    );
end entity sistema;

architecture behavior of sistema is

    component microcontrolador is
        port (
            clk_clk                             : in  std_logic;
            pino_d_external_connection_export   : out std_logic_vector(15 downto 0);
            pino_div_external_connection_export : out std_logic_vector(2 downto 0);
            pino_max_external_connection_export : out std_logic_vector(15 downto 0);
            reset_reset_n                       : in  std_logic
        );
    end component;

    component gerador_PWM is
        port (
            D      : in  std_logic_vector(15 downto 0);  
            max    : in  std_logic_vector(15 downto 0);  
            clk_in : in  std_logic;
            reset  : in  std_logic;
            div    : in  std_logic_vector(2 downto 0);   
            ypwm   : out std_logic
        );
    end component;

    signal signal_D   : std_logic_vector(15 downto 0);
    signal signal_max : std_logic_vector(15 downto 0);
    signal signal_div : std_logic_vector(2 downto 0);

begin

    LO: microcontrolador
    port map (
        clk_clk                             => CLOCK_50,
        pino_d_external_connection_export   => signal_D,
        pino_div_external_connection_export => signal_div,
        pino_max_external_connection_export => signal_max,
        reset_reset_n                       => KEY(0)
    );

    PW: gerador_PWM
    port map (
        D      => signal_D,
        max    => signal_max,
        clk_in => CLOCK_50,
        reset  => KEY(0),
        div    => signal_div,
        ypwm   => GPIO(0)
    );

end architecture behavior;
