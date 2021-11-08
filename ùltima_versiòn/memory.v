module memory #(
    parameter MEM_SIZE = 8,             // Tamaño de la memoria (# de entradas)
    parameter WORD_SIZE = 10,           // Cantidad de bits
    parameter PTR = 3                   // Longitud de bits para el puntero
)(
    input [PTR-1:0] rd_ptr,             // Puntero de lectura
    input [PTR-1:0] wr_ptr,              // Puntero de escritura
    input [WORD_SIZE-1:0] data_in_MM,   // Datos de lectura
    input push,
    input pop,
    input reset,
    input clk,
    output reg [WORD_SIZE-1:0] data_out_MM  // Salida de la memoria
);
    
    reg [WORD_SIZE-1:0] Mem [MEM_SIZE-1:0]; // Celda de memoria
    integer i;

    always @(posedge clk)begin
        if(!reset)begin                     // Con el reset en bajo
            for(i=0; i < MEM_SIZE; i = i + 1) begin     // No entra nada a la memoria
                Mem[i] <= 0;
            end
        end
        else begin                           // Reset en alto
            if(push) begin
                Mem[wr_ptr] <= data_in_MM;   // Se hace POP, sale el dato de la memoria a la salida
            end      
        end 
    end

    always @(*)begin
        if(!reset) begin                      // Reset en bajo
            data_out_MM <= 0;                 // La salida de la memoria es 0
        end 
        else begin                            // Reset en alto 
            if(pop) begin
                data_out_MM <= Mem[rd_ptr];   // Se hace POP, sale el dato de la memoria a la salida
            end
            else begin 
                data_out_MM <= 0;                 // Si no se hace POP, no sale el dato de la memoria a la salida
            end
        end
    end 
endmodule