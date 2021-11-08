module Probador_fifo #(
    parameter MEM_SIZE = 8,
    parameter WORD_SIZE = 10,
    parameter PTR = 3
) (
    output reg clk,
    output reg reset,
	output reg fifo_wr,
    output reg fifo_rd,
	output reg [PTR-1:0] full_threshold,
    output reg [PTR-1:0] empty_threshold,
	output reg [WORD_SIZE-1:0] fifo_data_in,
	input error,
    input almost_empty,
    input almost_full,
    input fifo_full,
    input fifo_empty,
	input [WORD_SIZE-1:0] fifo_data_out,
    input [WORD_SIZE-1:0] fifo_data_out_sint
);
    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $dumpfile ("prueba.vcd");
        $dumpvars;

        $finish;
    end

    // Se guarda el checkeo de cada salida
    // checker[5] para error y error_sint
    // checker[4] para almost_empty y almost_empty_sint
    // checker[3] para almost_full y almost_full_sint
    // checker[2] para fifo_full y fifo_full_sint
    // checker[1] para fifo_empty y fifo_empty_sint
	// checker[0] para data_out_MM y data_out_MM_sint
	reg [5:0] checker; 
	always @(*) begin
		if (data_out_MM == data_out_MM_sint) checker = 1;
		else checker = 0;
	end
endmodule