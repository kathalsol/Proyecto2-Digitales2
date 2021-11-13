module write_logic 
#(                              // Se definen los parámetros de construcción
    parameter MEM_SIZE = 8,     // Tamaño de la memoria 
    parameter WORD_SIZE = 12,    // Cantidad de bits de cada palabra
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

// Se realiza la descripción para la señal de control push, 
// utilizando el estado (bajo o alto) de las señales fifo_wr y fifo_full
always @(*) begin
    if (reset) begin
        // Cuando reset está en alto
        // Dos casos válidos:
        //          1) se está escribiendo y no está lleno el fifo
        //          2) se está leyendo y se está escribiendo 
        if ((fifo_wr && !fifo_full) || (fifo_rd && fifo_wr)) begin
            push = 1; // señal de push en alto 
        end
        else begin  // casos contrarios
            push = 0; // Está lleno el fifo y se intenta escribir
        end
    end
    else begin
        // Cuando reset está en bajo
        push = 0; // push va a estar en cero, pues no se puede escribir
    end
end

// Se realiza la descripción para el puntero de escritura, 
// utilizando el estado (bajo o alto) de las señales fifo_wr y fifo_full
always @(posedge clk) begin
    if (!reset) begin
        // Cuando reset está en bajo
        wr_ptr <= 0; // puntero de escritura es cero
    end 
    else begin
        // Cuando reset está en alto
        // Dos casos válidos:
        //          1) se está escribiendo y no está lleno el fifo
        //          2) se está leyendo y se está escribiendo
        if ((fifo_wr && !fifo_full) || (fifo_rd && fifo_wr)) begin
            wr_ptr <= wr_ptr + 1; // se suma uno al puntero para apuntar a la siguiente casilla

            // si el puntero llega a apuntar al último espacio es MEM, se debe reiniciar
            if (wr_ptr == MEM_SIZE-1) begin 
                wr_ptr <= 0; // se reinicia el puntero al valor más bajo
            end
        end
    end
end



endmodule