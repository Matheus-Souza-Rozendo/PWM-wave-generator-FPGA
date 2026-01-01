
module microcontrolador (
	clk_clk,
	reset_reset_n,
	pino_d_external_connection_export,
	pino_max_external_connection_export,
	pino_div_external_connection_export);	

	input		clk_clk;
	input		reset_reset_n;
	output	[15:0]	pino_d_external_connection_export;
	output	[15:0]	pino_max_external_connection_export;
	output	[2:0]	pino_div_external_connection_export;
endmodule
