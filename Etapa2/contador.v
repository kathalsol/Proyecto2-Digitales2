module contador #(
    // Cantidad de FIFOS de la etapa de salida
    parameter FIFO_UNITS = 4,
    // Cantidad de bits necesarios para acceder cada FIFO
    // INDEX = log2(FIFO_UNITS)
    parameter INDEX = 2
) (
    input clk,
    input reset,
    input req,
    input [INDEX-1:0] idx,
    input IDLE,
    input pop_0,
    input pop_1,
    input pop_2,
    input pop_3,
    output reg [4:0] cuenta,
    output reg valid
);
    // Se crean los registros intermedios counter
    reg [4:0] counter_0;
    reg [4:0] counter_1;
    reg [4:0] counter_2;
    reg [4:0] counter_3;

    always @(posedge clk) begin
        if(reset == 0) begin
            counter_0 <= 0;
            counter_1 <= 0;
            counter_2 <= 0;
            counter_3 <= 0;
        end    
        else begin  
            if(pop_0) counter_0 <= counter_0 + 1;

            if(pop_1) counter_1 <= counter_1 + 1;

            if(pop_2) counter_2 <= counter_2 + 1;

            if(pop_3) counter_3 <= counter_3 + 1;
        end
    end

    // IDLE: Todos los FIFOs están vacíos. Salida “IDDLE” en 1 sólo en este estado. 
    // Cambia a ACTIVE al tener un FIFO no vacío
    always @(*) begin
        // ya se realizó un ciclo de IDLE, así que las cuentas 
        // guardan los valores de las palabras que salieron de cada FIFO
        if (IDLE & req) begin // ahora estamos vacíos y queremos saber la cuenta 
            case (idx)
                2'b00: cuenta = counter_0;
                2'b01: cuenta = counter_1;
                2'b10: cuenta = counter_2;
                2'b11: cuenta = counter_3;
            endcase
            valid = 1;
        end
        // Caso contrario: no se han sacado todos los valores 
        //  y no se ha requerido valores entonces no se indica la cuenta
        else begin
            cuenta = 0;
            valid = 0;
        end
    end
endmodule
