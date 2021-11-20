module probador_maquina_estado #(
	// Tamaño de la memoria completa
    // parameter MEM_SIZE = 8,
	// Tamaño de cada celda de memoria, [11:10] clase [9:8] destino [7:0] datos
    // parameter WORD_SIZE = 12,
	// Cantidad de bits para referenciar la memoria completa
	// ptr = log2(MEM_SIZE)
    parameter PTR = 3
) (
	output reg clk,
	output reg reset,
    output reg init,
    output reg [PTR-1:0] full_threshold,
    output reg [PTR-1:0] empty_threshold,
    output reg [8:0] fifos_empty, 
	input [PTR-1:0] fifos_full_threshold,
    input [PTR-1:0] fifos_empty_threshold,
    input idle,
    input [1:0] state,
    input [PTR-1:0] fifos_full_threshold_sint,
    input [PTR-1:0] fifos_empty_threshold_sint,
    input idle_sint,
    input [1:0] state_sint
);
	initial clk = 0;
	always #1 clk = ~clk;

	initial begin
		$dumpfile ("maquina.vcd");
		$dumpvars;

		reset <= 0;
        init <= 0; 
		full_threshold <= 3'b110;
        empty_threshold <= 3'b001;
        fifos_empty <= 3'b000;
		@(posedge clk);
		reset <= 1;
		@(posedge clk);
        init <= 1;
        @(posedge clk);
        init <= 0;
        @(posedge clk);
        fifos_empty <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        fifos_empty <= 9'b111111111;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        init <= 1;
        full_threshold <= 3'b010;
        empty_threshold <= 3'b100;
        @(posedge clk);
        @(posedge clk);
        init <= 0;
		@(posedge clk);
        fifos_empty <= 0;
        @(posedge clk);
        @(posedge clk);
		@(posedge clk);
		$finish;
	end

endmodule