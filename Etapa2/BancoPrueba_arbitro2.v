`timescale 1ns/1ns
`include "arbitro2.v"
`include "arbitro2_sint.v"
`include "cmos_cells.v"
`include "Probador_arbitro2.v"

module BancoPrueba_arbitro2();
    parameter WORD_SIZE = 12;
    //parameter FIFO_UNITS = 4;

    wire clk;
    wire reset;
    wire [WORD_SIZE-1:0] data_in_arb;
    wire fifo_empty;
    wire [3:0] fifos_almost_full;
    wire [WORD_SIZE-1:0] data_out_arb;
    wire [WORD_SIZE-1:0] data_out_arb_sint;
    wire pop;
    wire pop_sint;
    wire [3:0] push;
    wire [3:0] push_sint;
 

    arbitro2 #( .WORD_SIZE(WORD_SIZE)) arbitro_cond1 (
                                // entradas
                                .clk(clk),  
                                .reset(reset),
                                .data_in_arb(data_in_arb),
                                .fifo_empty(fifo_empty),
                                .fifos_almost_full(fifos_almost_full),

                                // salidas
                                .data_out_arb(data_out_arb),
                                .pop(pop),
                                .push(push));

    arbitro2_sint #(.WORD_SIZE(WORD_SIZE)) arbitro2_sint1 ( 
                                    // entradas
                                    .clk(clk),  
                                    .reset(reset),
                                    .data_in_arb(data_in_arb),
                                    .fifo_empty(fifo_empty),
                                    .fifos_almost_full(fifos_almost_full),
                                    // salidas 
                                    .data_out_arb_sint(data_out_arb_sint),
                                    .pop_sint(pop_sint),
                                    .push_sint(push_sint)
                                    );
                                   
    Probador_arbitro2 #(.WORD_SIZE(WORD_SIZE))  
                    Probador_arbitro21 (
                                        .clk(clk),  
                                        .reset(reset),
                                        .data_in_arb(data_in_arb),
                                        .fifo_empty(fifo_empty),
                                        .fifos_almost_full(fifos_almost_full),
                                        // salidas conductuales y escructurales
                                        .data_out_arb(data_out_arb),
                                        .pop(pop),
                                        .push(push),
                                        .data_out_arb_sint(data_out_arb_sint),
                                        .pop_sint(pop_sint));

// checker para cuenta, cuenta_sint, valid y 
reg [2:0] checker; 

always @(*) begin
    if (data_out_arb == data_out_arb_sint) checker[2] = 1;
    else checker[2] = 0;
    if (push == push_sint) checker[1] = 1;
	else checker[1] = 0;
    if (pop == pop_sint) checker[0] = 1;
    else checker[0] = 0;
	end

endmodule
   
