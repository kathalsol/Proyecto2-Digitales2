`timescale 1ns/1ns
`include "contador.v"
`include "contador_sint.v"
`include "cmos_cells.v"
`include "Probador_contador.v"

module BancoPrueba_contador();
    parameter FIFO_UNITS = 4;
    parameter INDEX = 2;

    wire clk;
    wire reset;
    wire req;
    wire [INDEX-1:0] idx;
    wire IDLE;
    wire pop_0;
    wire pop_1;
    wire pop_2;
    wire pop_3;
    wire [4:0] cuenta;
    wire [4:0] cuenta_sint;
    wire valid;
    wire valid_sint;
   


    contador #(.FIFO_UNITS(FIFO_UNITS), 
                    .INDEX(INDEX)) contador_cond1 (
                                        .clk(clk),  
                                        .reset(reset),
                                        .req(req),
                                        .idx(idx),
                                        .IDLE(IDLE),
                                        .pop_0(pop_0),
                                        .pop_1(pop_1),
                                        .pop_2(pop_2),
                                        .pop_3(pop_3),
                                        .cuenta(cuenta),
                                        .valid(valid)
);

    contador_sint #(.FIFO_UNITS(FIFO_UNITS), 
                    .INDEX(INDEX)) contador_sint1 (
                                        .clk(clk), 
                                        .reset(reset),
                                        .req(req),
                                        .idx(idx),
                                        .IDLE(IDLE),
                                        .pop_0(pop_0),
                                        .pop_1(pop_1),
                                        .pop_2(pop_2),
                                        .pop_3(pop_3),
                                        .cuenta_sint(cuenta_sint),
                                        .valid_sint(valid_sint)
);

    Probador_contador #(.FIFO_UNITS(FIFO_UNITS), 
                    .INDEX(INDEX)) probador_contador1 (
                                        .clk(clk), 
                                        .reset(reset),
                                        .req(req),
                                        .idx(idx),
                                        .IDLE(IDLE),
                                        .pop_0(pop_0),
                                        .pop_1(pop_1),
                                        .pop_2(pop_2),
                                        .pop_3(pop_3),
                                        .cuenta(cuenta),
                                        .cuenta_sint(cuenta_sint),
                                        .valid(valid),
                                        .valid_sint(valid_sint)
);

// Se guarda el checkeo de cada salida
// checker para cuenta, cuenta_sint, valid y 
reg [1:0] checker; 

always @(*) begin
	if (cuenta == cuenta_sint) checker[1] = 1;
	else checker[1] = 0;
    if (valid == valid_sint) checker[0] = 1;
    else checker[0] = 0;
	end

endmodule
   

