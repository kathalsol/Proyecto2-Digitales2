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
        
        // Inicio de la simulación
        reset <= 0;
        push <= 0;
        pop <= 0;
        wr_ptr <= 0;
        rd_ptr <= 0;
        data_in_MM <= 0;

        // Se desactiva el reset
        @(posedge clk);
        reset <= 1;

        // Se escribe un dato en la memoria[2]
        @(posedge clk);
        push <= 1;
        wr_ptr <= 'b010;
        data_in_MM <= 'b1010101100;

        // Se lee el dato de la memoria[2]
        // Se escribe un dato en la memoria[4]
        @(posedge clk);
        wr_ptr <= 'b100;
        data_in_MM <= 'b1010010101;
        pop <= 1;
        rd_ptr <= 'b010;

        // Se escribe un dato en la memoria[7]
        @(posedge clk);
        wr_ptr <= 'b111;
        data_in_MM <= 'b1110011101;
        pop <= 0;
        rd_ptr <= 'b010;

        // Se lee el dato en la memoria[6]
        @(posedge clk);
        pop <= 1;
        rd_ptr <= 'b110;

        // Se lee el dato en la memoria[4]
        @(posedge clk);
        pop <= 1;
        rd_ptr <= 'b100;

        @(posedge clk);
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