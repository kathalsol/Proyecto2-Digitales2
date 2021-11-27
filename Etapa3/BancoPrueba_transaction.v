`timescale 1ns/1ns
`include "Probador_transaction.v"
`include "transaction_sint.v"
`include "transaction.v"
`include "cmos_cells.v"

module BancoPrueba_transaction ();
    
    parameter MEM_SIZE = 8;
    parameter WORD_SIZE = 12;
    parameter PTR = 3;
    parameter INDEX = 2;
    
    wire clk;
    wire reset;
    wire init;
    wire [PTR-1:0] full_threshold;
    wire [PTR-1:0] empty_threshold;
    wire probador_push;
    wire [WORD_SIZE-1:0] data_in;
    wire [3:0] probador_pop;
    wire [1:0] idx;
    wire req;
    
    // outputs
    wire [WORD_SIZE-1:0] data_out_S0;
    wire [WORD_SIZE-1:0] data_out_S1;
    wire [WORD_SIZE-1:0] data_out_S2;
    wire [WORD_SIZE-1:0] data_out_S3;
    wire valid;
    wire [1:0] state;
    wire [1:0] state_sint;
    wire [4:0] cuenta;
    wire [6:0] contador_4;  
    wire [WORD_SIZE-1:0] data_out_S0_sint;
    wire [WORD_SIZE-1:0] data_out_S1_sint;
    wire [WORD_SIZE-1:0] data_out_S2_sint;
    wire [WORD_SIZE-1:0] data_out_S3_sint;
    wire valid_sint;
    wire [4:0] cuenta_sint;
    wire [6:0] contador_4_sint;

    



    transaction #(      .MEM_SIZE(MEM_SIZE), 
                        .WORD_SIZE(WORD_SIZE), 
                        .PTR(PTR),
                        .INDEX(INDEX)) transaction_1 ( 
                                                        .clk(clk),
                                                        .reset(reset),
                                                        .init(init),
                                                        .full_threshold(full_threshold),
                                                        .empty_threshold(empty_threshold),
                                                        .probador_push(probador_push),
                                                        .data_in(data_in),
                                                        .probador_pop(probador_pop),
                                                        .idx(idx), 
                                                        .req(req),
    
                                                        // outputs
                                                        .data_out_S0(data_out_S0),
                                                        .data_out_S1(data_out_S1),
                                                        .data_out_S2(data_out_S2),
                                                        .data_out_S3(data_out_S3),
                                                        .valid(valid),
                                                        .cuenta(cuenta),
                                                        .contador_4(contador_4),
                                                        .state(state)  
                                                        );
    
    transaction_sint #(     .MEM_SIZE(MEM_SIZE), 
                            .WORD_SIZE(WORD_SIZE), 
                            .PTR(PTR),
                            .INDEX(INDEX)) transaction_sint_1 ( 
                                                        .clk(clk),
                                                        .reset(reset),
                                                        .init(init),
                                                        .full_threshold(full_threshold),
                                                        .empty_threshold(empty_threshold),
                                                        .probador_push(probador_push),
                                                        .data_in(data_in),
                                                        .probador_pop(probador_pop),
                                                        .idx(idx), 
                                                        .req(req),
    
                                                        // outputs
                                                        .data_out_S0_sint(data_out_S0_sint),
                                                        .data_out_S1_sint(data_out_S1_sint),
                                                        .data_out_S2_sint(data_out_S2_sint),
                                                        .data_out_S3_sint(data_out_S3_sint),
                                                        .valid_sint(valid_sint),
                                                        .cuenta_sint(cuenta_sint),
                                                        .contador_4_sint(contador_4_sint),
                                                        .state_sint(state_sint)

    );

    Probador_transaction #( .MEM_SIZE(MEM_SIZE), 
                            .WORD_SIZE(WORD_SIZE), 
                            .PTR(PTR),
                            .INDEX(INDEX)) probador_1 (
                                                        .clk(clk),
                                                        .reset(reset),
                                                        .init(init),
                                                        .full_threshold(full_threshold),
                                                        .empty_threshold(empty_threshold),
                                                        .probador_push(probador_push),
                                                        .data_in(data_in),
                                                        .probador_pop(probador_pop),
                                                        .idx(idx),
                                                        .req(req),
    
                                                        // outputs
                                                        .data_out_S0(data_out_S0),
                                                        .data_out_S1(data_out_S1),
                                                        .data_out_S2(data_out_S2),
                                                        .data_out_S3(data_out_S3),
                                                        .valid(valid),
                                                        .cuenta(cuenta),
                                                        .contador_4(contador_4),
                                                        .state(state), 
                                                        .data_out_S0_sint(data_out_S0_sint),
                                                        .data_out_S1_sint(data_out_S1_sint),
                                                        .data_out_S2_sint(data_out_S2_sint),
                                                        .data_out_S3_sint(data_out_S3_sint),
                                                        .valid_sint(valid_sint),
                                                        .cuenta_sint(cuenta_sint),
                                                        .contador_4_sint(contador_4_sint),
                                                        .state_sint(state_sint)                          
                                                        );
    reg [7:0] checker;
    
    always @(*) begin    
        if(data_out_S0_sint ==  data_out_S0) checker[0] = 1;
        else checker[0] = 0;
        
        if( data_out_S1_sint == data_out_S1) checker[1] = 1;
        else checker[1] = 0;
        
        if(data_out_S2_sint == data_out_S2) checker[2] = 1;
        else checker[2] = 0;
        
        if( data_out_S3_sint == data_out_S3_sint) checker[3] = 1;
        else checker[3] = 0;
        
        if(valid_sint == valid_sint) checker[4] = 1;
        else checker[4] = 0;
        
        if(cuenta_sint == cuenta) checker[5] = 1;
        else checker[5] = 0;
        
        if(contador_4_sint == contador_4) checker[6] = 1;
        else checker[6] = 0;
        
        if(state_sint == state) checker[7] = 1;
        else checker[7] = 0;
    end   


endmodule