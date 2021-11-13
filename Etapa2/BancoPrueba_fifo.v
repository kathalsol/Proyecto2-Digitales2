`timescale 1ns/1ns
`include "fifo.v"
`include "fifo_sint.v"
`include "Probador_fifo.v"
`include "cmos_cells.v"

module BancoPrueba_fifo ();
    parameter MEM_SIZE = 8;
    parameter WORD_SIZE = 12;
    parameter PTR = 3;

    wire [PTR-1:0] full_threshold;
    wire [PTR-1:0] empty_threshold;
    wire fifo_wr;
    wire fifo_rd;
    wire [WORD_SIZE-1:0] fifo_data_in;
    wire push;
    wire pop;
    wire reset;
    wire clk;
    wire almost_empty;
    wire almost_full;
    wire fifo_full;
    wire fifo_empty;
    wire [WORD_SIZE-1:0] fifo_data_out;
    wire [WORD_SIZE-1:0] fifo_data_out_sint;


    fifo #(.MEM_SIZE(MEM_SIZE), 
                    .WORD_SIZE(WORD_SIZE), 
                    .PTR(PTR)) fifo_cond1 (
                                        .fifo_wr(fifo_wr),   
                                        .fifo_rd(fifo_rd),   
                                        .fifo_full(fifo_full), 
                                        .fifo_empty(fifo_empty),
                                        .fifo_data_in(fifo_data_in),
                                        .full_threshold(full_threshold),
                                        .empty_threshold(empty_threshold),
                                        .clk(clk),       
                                        .reset(reset),  
                                        .error(error),    
                                        .fifo_data_out(fifo_data_out),
                                        .almost_empty(almost_empty),
                                        .almost_full(almost_full)     	    
);

    fifo_sint #(.MEM_SIZE(MEM_SIZE),
                .WORD_SIZE(WORD_SIZE),
                .PTR(PTR)) fifo_sint1 (
                                        .fifo_wr(fifo_wr),   
                                        .fifo_rd(fifo_rd),   
                                        .fifo_full_sint(fifo_full_sint), 
                                        .fifo_empty_sint(fifo_empty_sint),
                                        .fifo_data_in(fifo_data_in),
                                        .full_threshold(full_threshold),
                                        .empty_threshold(empty_threshold),
                                        .clk(clk),       
                                        .reset(reset),  
                                        .error_sint(error_sint),    
                                        .fifo_data_out_sint(fifo_data_out_sint),
                                        .almost_empty_sint(almost_empty_sint),
                                        .almost_full_sint(almost_full_sint) 
                );

    Probador_fifo #(.MEM_SIZE(MEM_SIZE), 
                    .WORD_SIZE(WORD_SIZE), 
                    .PTR(PTR)) probador_fifo1 (
                                            .clk(clk),
                                            .fifo_data_in(fifo_data_in),
                                            .reset(reset),
                                            .fifo_wr(fifo_wr),
                                            .fifo_rd(fifo_rd),
                                            .full_threshold(full_threshold),
                                            .empty_threshold(empty_threshold),
                                            .error(error),
                                            .almost_empty(almost_empty),
                                            .almost_full(almost_full),
                                            .fifo_full(fifo_full), 
                                            .fifo_empty(fifo_empty),
                                            .fifo_data_out(fifo_data_out),
                                            .error_sint(error_sint),
                                            .almost_empty_sint(almost_empty_sint),
                                            .almost_full_sint(almost_full_sint),
                                            .fifo_full_sint(fifo_full_sint),
                                            .fifo_empty_sint(fifo_empty_sint),
                                            .fifo_data_out_sint(fifo_data_out_sint)
                                            );

endmodule
   

