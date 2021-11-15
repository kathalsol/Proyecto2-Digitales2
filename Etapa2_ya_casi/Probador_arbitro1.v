module Probador_arbitro1 #(
    parameter WORD_SIZE = 12
) (
    output reg clk,
    output reg reset,
    output reg [3:0] fifos_almost_full,
    output reg [3:0] fifos_empty,
    output reg [WORD_SIZE-1:0] fifo_data_in0,
    output reg [WORD_SIZE-1:0] fifo_data_in1,
    output reg [WORD_SIZE-1:0] fifo_data_in2,
    output reg [WORD_SIZE-1:0] fifo_data_in3,
    input [3:0] fifos_push,
    input [3:0] fifos_pop,
    input [WORD_SIZE-1:0] fifo_data_out_cond0,
    input [WORD_SIZE-1:0] fifo_data_out_cond1,
    input [WORD_SIZE-1:0] fifo_data_out_cond2,
    input [WORD_SIZE-1:0] fifo_data_out_cond3,
    input [3:0] fifos_push_sint,
    input [3:0] fifos_pop_sint,
    input [WORD_SIZE-1:0] fifo_data_out_sint0,
    input [WORD_SIZE-1:0] fifo_data_out_sint1,
    input [WORD_SIZE-1:0] fifo_data_out_sint2,
    input [WORD_SIZE-1:0] fifo_data_out_sint3
);

    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $dumpfile ("arbitro1.vcd");
        $dumpvars;

        reset <= 0;
        fifos_almost_full <= 0;
        fifos_empty <= 0;
        fifo_data_in0 <= 0;
        fifo_data_in1 <= 0;
        fifo_data_in2 <= 0;
        fifo_data_in3 <= 0;

        @(posedge clk);
        reset <= 1;
        fifo_data_in0 <= 12'b101011001100;
        fifo_data_in1 <= 12'b101011001111;
        fifo_data_in2 <= 12'b111011001101;
        fifo_data_in3 <= 12'b001011001111;

        @(posedge clk);
        fifo_data_in0 <= 12'b101101001100;
        fifo_data_in1 <= 12'b101011111111;
        fifo_data_in2 <= 12'b111011001101;
        fifo_data_in3 <= 12'b011011000011;

        @(posedge clk);
        fifo_data_in0 <= 12'b001111011100;
        fifo_data_in1 <= 12'b111011001011;
        fifo_data_in2 <= 12'b111011001101;
        fifo_data_in3 <= 12'b011011101011;

        @(posedge clk);
        fifo_data_in0 <= 12'b001111011110;
        fifo_data_in1 <= 12'b011011001011;
        fifo_data_in2 <= 12'b101011101101;
        fifo_data_in3 <= 12'b011011111011;

        @(posedge clk);
        fifo_data_in0 <= 12'b101111011111;
        fifo_data_in1 <= 12'b011011101011;
        fifo_data_in2 <= 12'b101011101101;
        fifo_data_in3 <= 12'b111011111111;

        @(posedge clk);
        fifo_data_in0 <= 12'b111111011111;
        fifo_data_in1 <= 12'b011011111011;
        fifo_data_in2 <= 12'b101011101101;
        fifo_data_in3 <= 12'b001011110011;

        @(posedge clk);
        reset <= 1;
        fifo_data_in0 <= 12'b101111011111;
        fifo_data_in1 <= 12'b011011101011;
        fifo_data_in2 <= 12'b101011101101;
        fifo_data_in3 <= 12'b111011111111;

        @(posedge clk);
        fifo_data_in0 <= 12'b111001011111;
        fifo_data_in1 <= 12'b111011101001;
        fifo_data_in2 <= 12'b101011101101;
        fifo_data_in3 <= 12'b001011001111;
        fifos_almost_full <= 4'b0010;

        @(posedge clk);
        fifo_data_in0 <= 12'b111001011111;
        fifo_data_in1 <= 12'b111011101001;
        fifo_data_in2 <= 12'b101011101101;
        fifo_data_in3 <= 12'b001011001111;
        fifos_almost_full <=  4'b1010;
        fifos_empty <= 4'b1000;

        @(posedge clk);
        fifo_data_in0 <= 12'b111001011001;
        fifo_data_in1 <= 12'b100011101001;
        fifo_data_in2 <= 12'b101011101101;
        fifo_data_in3 <= 12'b101010001111;
        fifos_almost_full <=  4'b1011;

        @(posedge clk);
        fifo_data_in0 <= 12'b111001011001;
        fifo_data_in1 <= 12'b100011101001;
        fifo_data_in2 <= 12'b101011101101;
        fifo_data_in3 <= 12'b101010001111;
        fifos_almost_full <=  4'b1111;
        fifos_empty <= 4'b0010;

        @(posedge clk);
        fifo_data_in0 <= 12'b111001011001;
        fifo_data_in1 <= 12'b111011101001;
        fifo_data_in2 <= 12'b111011101101;
        fifo_data_in3 <= 12'b011010001111;
        fifos_almost_full <=  4'b1111;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $finish;
    end
    
endmodule