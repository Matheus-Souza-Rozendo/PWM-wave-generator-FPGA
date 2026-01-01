	component microcontrolador is
		port (
			clk_clk                             : in  std_logic                     := 'X'; -- clk
			reset_reset_n                       : in  std_logic                     := 'X'; -- reset_n
			pino_d_external_connection_export   : out std_logic_vector(15 downto 0);        -- export
			pino_max_external_connection_export : out std_logic_vector(15 downto 0);        -- export
			pino_div_external_connection_export : out std_logic_vector(2 downto 0)          -- export
		);
	end component microcontrolador;

	u0 : component microcontrolador
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                          clk.clk
			reset_reset_n                       => CONNECTED_TO_reset_reset_n,                       --                        reset.reset_n
			pino_d_external_connection_export   => CONNECTED_TO_pino_d_external_connection_export,   --   pino_d_external_connection.export
			pino_max_external_connection_export => CONNECTED_TO_pino_max_external_connection_export, -- pino_max_external_connection.export
			pino_div_external_connection_export => CONNECTED_TO_pino_div_external_connection_export  -- pino_div_external_connection.export
		);

