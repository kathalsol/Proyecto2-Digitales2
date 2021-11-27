`timescale 1ns/1ns
`include "maquina_estado.v"
`include "maquina_estado_sint.v"
`include "cmos_cells.v"
`include "Probador_maquina.v"

module BancoPrueba_maquina ();
    
/// Tamaño de la memoria completa
    parameter MEM_SIZE = 8;
	// Tamaño de cada celda de memoria, [11:10] clase [9:8] destino [7:0] datos
    parameter WORD_SIZE = 12;
	// Cantidad de bits para referenciar la memoria completa
	// ptr = log2(MEM_SIZE)
    parameter PTR = 3;


	wire clk;
	wire reset;
    wire init;
    wire [PTR-1:0] full_threshold;
    wire [PTR-1:0] empty_threshold;
    wire [8:0] fifos_empty;
	wire [PTR-1:0] fifos_full_threshold;
    wire [PTR-1:0] fifos_empty_threshold;
    wire idle;
    wire [1:0] state;
	wire [PTR-1:0] fifos_full_threshold_sint;
    wire [PTR-1:0] fifos_empty_threshold_sint;
    wire idle_sint;
    wire [1:0] state_sint;


    maquina_estado #( .PTR(PTR)) maquina_estado1 (
                                // entradas
                                .clk(clk),  
                                .reset(reset),
                                .init(init),
                                .full_threshold(full_threshold),
                                .empty_threshold(empty_threshold),
                                .fifos_empty(fifos_empty),
                                

                                // salidas

                                .fifos_full_threshold(fifos_full_threshold),
                                .fifos_empty_threshold(fifos_empty_threshold),
                                .idle(idle),
                                .state(state));

    maquina_estado_sint #(.PTR(PTR)) maquina_estado_sint1 ( 
                                    // entradas
                                .clk(clk),  
                                .reset(reset),
                                .init(init),
                                .full_threshold(full_threshold),
                                .empty_threshold(empty_threshold),
                                .fifos_empty(fifos_empty),      
                                // salidas

                                .fifos_full_threshold_sint(fifos_full_threshold_sint),
                                .fifos_empty_threshold_sint(fifos_empty_threshold_sint),
                                .idle_sint(idle_sint),
                                .state_sint(state_sint));
                                   
    probador_maquina_estado #(.PTR(PTR))  
                    probador_maquina_estado1 (
                                            .clk(clk),
	                                        .reset(reset),
                                            .init(init),
                                            .full_threshold(full_threshold),
                                            .empty_threshold(empty_threshold),
                                            .fifos_empty(fifos_empty), 
                                            .fifos_full_threshold_sint(fifos_full_threshold_sint),
                                            .fifos_empty_threshold_sint(fifos_empty_threshold_sint),
                                            .idle_sint(idle_sint),
                                            .state_sint(state_sint),
                                            .fifos_full_threshold(fifos_full_threshold),
                                            .fifos_empty_threshold(fifos_empty_threshold),
                                            .idle(idle),
                                            .state(state)       
                                        );

// checker para threshold,  
reg [3:0] checker; 

always @(*) begin
    if (fifos_full_threshold == fifos_full_threshold_sint) checker[3] = 1;
    else checker[3] = 0;
    if (fifos_empty_threshold == fifos_empty_threshold_sint) checker[2] = 1;
	else checker[2] = 0;
    if (idle == idle_sint) checker[1] = 1;
    else checker[1] = 0;
    if (state == state_sint) checker[0] = 1;
    else checker[0] = 0;
	end




endmodule



