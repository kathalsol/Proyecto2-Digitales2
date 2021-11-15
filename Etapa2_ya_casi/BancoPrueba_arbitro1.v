`timescale 1ns/1ns
`include "arbitro1.v"
`include "arbitro1_sint.v"
`include "cmos_cells.v"
`include "Probador_arbitro1.v"

module BancoPrueba_arbitro1();
    parameter WORD_SIZE = 12;
    //parameter FIFO_UNITS = 4;
    
    wire clk;
    wire reset;
    wire [3:0] fifos_almost_full;
    wire [3:0] fifos_empty;
    wire [WORD_SIZE-1:0] fifo_data_in0;
    wire [WORD_SIZE-1:0] fifo_data_in1;
    wire [WORD_SIZE-1:0] fifo_data_in2;
    wire [WORD_SIZE-1:0] fifo_data_in3;
    wire [3:0] fifos_push;
    wire [3:0] fifos_pop;
    wire [WORD_SIZE-1:0] fifo_data_out_cond;
    wire [3:0] fifos_pop_sint;
    wire [3:0] fifos_push_sint;
    wire [WORD_SIZE-1:0] fifo_data_out_sint;
 

    arbitro1 #(.WORD_SIZE(WORD_SIZE)) arbitro_cond1 (
                                // entradas
                                .clk(clk),  
                                .reset(reset),
                                .fifo_data_in0(fifo_data_in0),
                                .fifo_data_in1(fifo_data_in1),
                                .fifo_data_in2(fifo_data_in2),
                                .fifo_data_in3(fifo_data_in3),
                                .fifos_almost_full(fifos_almost_full),
                                .fifos_empty(fifos_empty),

                                // salidas
                                .fifo_data_out_cond(fifo_data_out_cond),
                                .fifos_pop(fifos_pop),
                                .fifos_push(fifos_push));

    arbitro1_sint #(.WORD_SIZE(WORD_SIZE)) arbitro1_sint1 ( 
                                    // entradas
                                    .clk(clk),  
                                    .reset(reset),
                                    .fifo_data_in0(fifo_data_in0),
                                    .fifo_data_in1(fifo_data_in1),
                                    .fifo_data_in2(fifo_data_in2),
                                    .fifo_data_in3(fifo_data_in3),
                                    .fifos_almost_full(fifos_almost_full),
                                    .fifos_empty(fifos_empty),
                                    // salidas 
                                    .fifo_data_out_sint(fifo_data_out_sint),
                                    .fifos_pop_sint(fifos_pop_sint),
                                    .fifos_push_sint(fifos_push_sint)
                                    );
                                   
    Probador_arbitro1 #(.WORD_SIZE(WORD_SIZE))  
                    Probador_arbitro11 (
                                        .clk(clk),  
                                        .reset(reset),
                                        .fifo_data_in0(fifo_data_in0),
                                        .fifo_data_in1(fifo_data_in1),
                                        .fifo_data_in2(fifo_data_in2),
                                        .fifo_data_in3(fifo_data_in3),
                                        .fifos_almost_full(fifos_almost_full),
                                        .fifos_empty(fifos_empty),
                                        // salidas 
                                        .fifo_data_out_sint(fifo_data_out_sint),
                                        .fifos_pop_sint(fifos_pop_sint),
                                        .fifos_push_sint(fifos_push_sint),
                                        .fifo_data_out_cond(fifo_data_out_cond),
                                        .fifos_pop(fifos_pop),
                                        .fifos_push(fifos_push));

// checker para cuenta, cuenta_sint, valid y 
reg [2:0] checker; 

always @(*) begin
	if (fifo_data_out_sint == fifo_data_out_cond) checker[0] = 1;
	else checker[0] = 0;
    if (fifos_pop == fifos_pop_sint) checker[1] = 1;
	else checker[1] = 0;
	if (fifos_push == fifos_push_sint) checker[2] = 1;
	else checker[2] = 0;
end

endmodule