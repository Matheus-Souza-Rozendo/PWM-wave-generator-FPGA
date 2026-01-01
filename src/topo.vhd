library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity topo is
    port (CLOCK_50 : in  std_logic;
          GPIO     : out std_logic_vector(1 downto 0);
			 LEDR     : out std_logic_vector(1 downto 0);
		    KEY      : in  std_logic_vector(3 downto 0));
end topo;

architecture behavior of topo is


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
	 signal ypwm : std_logic;

begin

    PW: gerador_PWM
    port map (
        D      => std_logic_vector(to_unsigned(2500, 16)),
        max    => std_logic_vector(to_unsigned(4999, 16)),
        clk_in => CLOCK_50,
        reset  => KEY(0),
        div    => std_logic_vector(to_unsigned(0, 3)),
        ypwm   => ypwm
    );
	 
	 LEDR(0) <= ypwm;
	 GPIO(1) <= ypwm;

end behavior;
