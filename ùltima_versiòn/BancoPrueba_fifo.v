`include "fifo.v"
`include "fifo_sint.v"
`include "Probador_fifo.v"
`include "cmos_cells.v"

module BancoPrueba_fifo ();
    parameter MEM_SIZE = 8;
    parameter WORD_SIZE = 10;
    parameter PTR = 3;

    input [PTR-1:0] full_threshold;
    input [PTR-1:0] empty_threshold;
    input fifo_wr;
    input fifo_rd;
    input [WORD_SIZE-1:0] fifo_data_in;
    input push;
    input pop;
    input reset;
    input clk;
    input almost_empty;
    input almost_full;
    input fifo_full;
    input fifo_empty;
    input [WORD_SIZE-1:0] fifo_data_out;
    input [WORD_SIZE-1:0] fifo_data_out_sint;

      
fifo 
#(                              // Se definen los parámetros de construcción
    parameter MEM_SIZE = 4,     // Tamaño de la memoria 
    parameter WORD_SIZE = 6,    // Cantidad de bits de cada palabra
    parameter PTR = 3           // Cantidad de bits para el puntero
)
(
                     // Se definen las entradas y salidas del módulo
    input fifo_wr,   // Se utiliza como señal de control de escritura
    input fifo_rd,   // Se utiliza como senal de control de lectura
    input fifo_full, // señal fifo_full, indicación fifo lleno
    input clk,       // Señal de reloj
    input reset,     // Señal de reset
    output reg [PTR-1:0] wr_ptr,  // Señal de salida, indicador puntero escritura
    output reg push               // Señal de push, indicador de escribir en memoria
);



endmodule

