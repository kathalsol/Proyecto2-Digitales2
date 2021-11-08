module Probador_memory #(
    parameter MEM_SIZE = 8,
    parameter WORD_SIZE = 10,
    parameter PTR = 3
) (
    output reg [PTR-1:0] rd_ptr,
    output reg [PTR-1:0] wr_ptr,
    output reg [WORD_SIZE-1:0] data_in_MM,
    output reg push,
    output reg pop,
    output reg reset,
    output reg clk,
    input [WORD_SIZE-1:0] data_out_MM,
    input [WORD_SIZE-1:0] data_out_MM_sint
);
    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $dumpfile ("memory.vcd");
        $dumpvars;

        $finish;
    end

    // Se guarda el checkeo de cada salida
	// checker para data_out_MM y data_out_MM_sint
	reg checker; 
	always @(*) begin
		if (data_out_MM == data_out_MM_sint) checker = 1;
		else checker = 0;
	end
endmodule