`timescale 1ns/1ns
`include "cmos_cells.v"
`include "memory.v"
`include "memory_sint.v"
`include "Probador_memory.v"


module BancoPrueba_memory ();

    parameter MEM_SIZE = 8;
    parameter WORD_SIZE = 10;
    parameter PTR = 3;

    wire [PTR-1:0] rd_ptr;
    wire [PTR-1:0] wr_ptr;
    wire [WORD_SIZE-1:0] data_in_MM;
    wire push;
    wire pop;
    wire reset;
    wire clk;
    wire [WORD_SIZE-1:0] data_out_MM;
    wire [WORD_SIZE-1:0] data_out_MM_sint;

    memory #(.MEM_SIZE(MEM_SIZE), 
            .WORD_SIZE(WORD_SIZE), 
            .PTR(PTR)) memory_cond (
                                    .rd_ptr(rd_ptr),         
                                    .wr_ptr(wr_ptr),             
                                    .data_in_MM(data_in_MM),   
                                    .push(push),
                                    .pop(pop),
                                    .reset(reset),
                                    .clk(clk),
                                    .data_out_MM(data_out_MM)
                                    );

    memory_sint #(.MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR)) memory_sint (
                                    .rd_ptr(rd_ptr),         
                                    .wr_ptr(wr_ptr),             
                                    .data_in_MM(data_in_MM),   
                                    .push(push),
                                    .pop(pop),
                                    .reset(reset),
                                    .clk(clk),
                                    .data_out_MM_sint(data_out_MM_sint)
                                    );

    Probador_memory #(.MEM_SIZE(MEM_SIZE), 
                    .WORD_SIZE(WORD_SIZE), 
                    .PTR(PTR)) probador_mem (
                                            .rd_ptr(rd_ptr),
                                            .wr_ptr(wr_ptr),
                                            .data_in_MM(data_in_MM),
                                            .push(push),
                                            .pop(pop),
                                            .reset(reset),
                                            .clk(clk),
                                            .data_out_MM(data_out_MM),
                                            .data_out_MM_sint(data_out_MM_sint)
                                            );
                                        
endmodule