module read_logic 
#(                              // Se definen los parámetros de construcción
    parameter MEM_SIZE = 8,     // Tamaño de la memoria
    parameter WORD_SIZE = 10,   // Cantidad de bits de cada palabra
    parameter PTR = 3           // Cantidad de bits para el puntero
)
(                            // Se definen las entradas y salidas del módulo
    input fifo_rd,           // Se utiliza como senal de control de lectura
    input fifo_wr,           // Se utiliza como señal de control de escritura
    input fifo_empty,        // señal fifo_empty, indicación fifo vacío
    input clk,               // Señal de reloj
    input reset,             // Señal de reset
    output reg [PTR-1:0] rd_ptr,  // Señal de salida, indicador puntero lectura
    output reg pop                // Señal de pop, indicador de leer en memoria
);

// Se realiza la descripción para la señal de control push, 
// utilizando el estado (bajo o alto) de las señales fifo_rd y fifo_empty
always @(*) begin
    if (reset) begin
        // Cuando reset está en alto
        // Dos casos válidos:
        //          1) se está leyendo y el fifo no está vacío
        //          2) se está leyendo y se está escribiendo 
        if ((fifo_rd && !fifo_empty) || (fifo_rd && fifo_wr)) begin
            pop = 1; // señal de pop en alto 
        end
        else begin   // casos contrarios
            pop = 0; // Está vacío el fifo y se intenta leer
        end
    end
    else begin
        // Cuando reset está en bajo
        pop=0; // pop va a estar en cero, pues no se puede leer
    end
    
end


// Se realiza la descripción para el puntero de lectura, 
// utilizando el estado (bajo o alto) de las señales fifo_rd y fifo_empty
always @(posedge clk) begin
    if (!reset) begin
        // Cuando reset está en bajo
        rd_ptr <= 0; // puntero de lectura es cero
    end 
    else begin
        // Cuando reset está en alto
        // Dos casos válidos:
        //          1) se está leyendo y el fifo no está vacío
        //          2) se está leyendo y se está escribiendo
        if ((fifo_rd && !fifo_empty) || (fifo_rd && fifo_wr)) begin
            rd_ptr <= rd_ptr + 1; // se suma uno al puntero para apuntar a la siguiente casilla
            
            // si el puntero llega a apuntar al último espacio en MEM, se debe reiniciar
            if (rd_ptr == MEM_SIZE-1) begin 
                rd_ptr <= 0; // se reinicia el puntero al valor más bajo
            end
        end 
    end
end

endmodule