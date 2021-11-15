module Probador_contador #(
    parameter FIFO_UNITS = 4,
    parameter INDEX = 2
) (
    output reg clk,
    output reg reset,
    output reg req,
    output reg [INDEX-1:0] idx,
    output reg IDLE, 
    output reg pop_0,
    output reg pop_1,
    output reg pop_2,
    output reg pop_3,
    input [4:0] cuenta,
    input [4:0] cuenta_sint,
    input valid,
    input valid_sint
);

    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        $dumpfile ("contador.vcd");
        $dumpvars;
        
        // Inicio de la simulación
        reset <= 0;
        req <= 0;
        idx <= 0;
        IDLE <= 0;
        pop_0 <= 0;
        pop_1 <= 0;
        pop_2 <= 0;
        pop_3 <= 0;

        // Se desactiva el reset
        @(posedge clk);
        reset <= 1;

        @(posedge clk);
        pop_0 <= 1;
        pop_1 <= 0;
        pop_2 <= 0;
        pop_3 <= 1;

        @(posedge clk);
        pop_0 <= 1;
        pop_1 <= 1;
        pop_2 <= 0;
        pop_3 <= 0;
      
        @(posedge clk);
        pop_0 <= 0;
        pop_1 <= 1;
        pop_2 <= 1;
        pop_3 <= 0;

        @(posedge clk);
        pop_0 <= 1;
        pop_1 <= 1;
        pop_2 <= 0;
        pop_3 <= 1;

        @(posedge clk);
        pop_0 <= 1;
        pop_1 <= 0;
        pop_2 <= 1;
        pop_3 <= 1;

        @(posedge clk);
        pop_0 <= 0;
        pop_1 <= 0;
        pop_2 <= 0;
        pop_3 <= 1;
        req <= 1;

        @(posedge clk);
        pop_0 <= 0;
        pop_1 <= 0;
        pop_2 <= 0;
        pop_3 <= 0;
        idx <= 2'b01;
        IDLE <= 1;

        @(posedge clk);
        idx <= 2'b11;

        @(posedge clk);
        idx <= 2'b00;

        @(posedge clk);
        idx <= 2'b10;
        
        @(posedge clk);
        idx <= 2'b00;
        
        @(posedge clk);
        $finish;
    end

    
endmodule