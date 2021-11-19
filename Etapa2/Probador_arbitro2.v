module Probador_arbitro2 #(
    parameter WORD_SIZE = 12
    //parameter FIFO_UNITS = 4
) (
   
    output reg clk,
    output reg reset,
    output reg [WORD_SIZE-1:0] data_in_arb,
    output reg fifo_empty,
    output reg [3:0] fifos_almost_full,
    input [WORD_SIZE-1:0] data_out_arb,
    input [WORD_SIZE-1:0] data_out_arb_sint,
    input pop,
    input pop_sint,
    input [3:0] push,
    input [3:0] push_sint
);
    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $dumpfile ("arbitro2.vcd");
        $dumpvars;
        
        // Inicio de la simulación
        reset <= 0;
        data_in_arb <= 0; 
        fifo_empty <=0;
        fifos_almost_full <= 0;

        // Se desactiva el reset
        @(posedge clk);
        reset <= 1;
        data_in_arb <= 12'b111011100011; 

        @(posedge clk);
        data_in_arb <= 12'b001011100011; 
        fifo_empty <= 0;
        fifos_almost_full <= 0;

        @(posedge clk);
        data_in_arb <= 12'b110011110011; 
      
        @(posedge clk);
        data_in_arb <= 12'b100000110001;  

        @(posedge clk);
        data_in_arb <= 12'b011110111101;
        
        @(posedge clk);
        data_in_arb <= 12'b111111111101;

        @(posedge clk);
        fifo_empty <= 1;

        @(posedge clk);
        data_in_arb <= 12'b011111111101;
        
        @(posedge clk);
        fifo_empty <= 0;
        data_in_arb <= 12'b001110011101;
        fifos_almost_full <= 4'b0001;

        
        @(posedge clk);
        data_in_arb <= 12'b111110001101;
        fifos_almost_full <= 4'b1000;

        @(posedge clk);
        data_in_arb <= 12'b011110011101;
        fifos_almost_full <= 4'b0010;

        @(posedge clk);
        data_in_arb <= 12'b100110111011;
        fifos_almost_full <= 4'b0100;
        
        @(posedge clk);
        data_in_arb <= 12'b100110111011;
        fifos_almost_full <= 4'b1111;
        
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        $finish;
    end
endmodule