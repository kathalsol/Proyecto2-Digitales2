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
    input error_sint,
    input almost_empty_sint,
    input almost_full_sint,
    input fifo_full_sint,
    input fifo_empty_sint,
    input [WORD_SIZE-1:0] fifo_data_out_sint
);
    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $dumpfile ("fifo.vcd");
        $dumpvars;

        reset <= 0;
        fifo_wr <= 0;
        fifo_rd <= 0;
        full_threshold <= 'b000;
        empty_threshold <= 'b000;
        fifo_data_in <= 'b0000000000;


        @(posedge clk);
        reset <= 1;
        fifo_wr <= 1;
        fifo_rd <= 0;
        full_threshold <= 'b110;
        empty_threshold <= 'b001;
        fifo_data_in <= 10'b1111111111;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 1;
        fifo_data_in <= 10'b1010110011;

        @(posedge clk);
        fifo_wr <= 0;
        fifo_rd <= 1;
        fifo_data_in <= 10'b1010110111;

        @(posedge clk);
        reset <= 0;
        fifo_wr <= 0;
        fifo_rd <= 1;
        fifo_data_in <= 10'b1010110111;

        @(posedge clk);
        reset <= 0;
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1110110111;

        @(posedge clk);
        reset <= 1;
        fifo_wr <= 0;
        fifo_rd <= 1;
        fifo_data_in <= 10'b1110110010;

        @(posedge clk);
        fifo_wr <= 0;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1110100010;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1111100010;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1111110010;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1011110010;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1011110010;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b0011110010;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1011110110;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1111110110;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1111110111;

        @(posedge clk);
        fifo_wr <= 1;
        fifo_rd <= 0;
        fifo_data_in <= 10'b1101010111;

        @(posedge clk);
        $finish;
    end

    // Se guarda el checkeo de cada salida
    // checker[5] para error y error_sint
    // checker[4] para almost_empty y almost_empty_sint
    // checker[3] para almost_full y almost_full_sint
    // checker[2] para fifo_full y fifo_full_sint
    // checker[1] para fifo_empty y fifo_empty_sint
	// checker[0] para fifo_data_out y fifo_data_out_sint
	reg [5:0] checker;
	always @(*) begin
        if (error == error_sint) checker[5] = 1;
        else checker[5] = 0;
        
        if (almost_empty == almost_empty_sint) checker[4] = 1;
        else checker[4] = 0;

        if (almost_full == almost_full_sint) checker[3] = 1;
        else checker[3] = 0;

        if (fifo_full == fifo_full_sint) checker[2] = 1;
        else checker[2] = 0;

        if (fifo_empty == fifo_empty_sint) checker[1] = 1;
        else checker[1] = 0;

		if (fifo_data_out == fifo_data_out_sint) checker[0] = 1;
		else checker[0] = 0;
	end
endmodule