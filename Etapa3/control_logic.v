/*Proyecto 2
Circuitos Digitales 2
Descripcion: modulo de control del fifo, indica si la memoria esta casi llena o vacia y entrega una senal de error en caso de rebase*/

//Modulo de control
module control_logic 
#(
    parameter MEM_SIZE = 8,   //Tamano de memoria
    parameter WORD_SIZE = 10,   //Cantidad de bits de una palabra
    parameter PTR = 3        //Cantidad de bits para representar el numero de celdas de memoria en binario
)
(
    input [PTR-1:0] full_threshold,  //Umbral para indicar cuando esta casi lleno
    input [PTR-1:0] empty_threshold, //Umbral para indicar cuando esta casi vacio
    input fifo_rd,                    //Senal para permitir lectura
    input fifo_wr,                    //Senal para permitir escritura
    input clk,                        
    input reset,                       
    output reg error,               // Senal de error para indicar rebase o lectura vacia
    output reg almost_empty,        // Bandera de warning cuando la memoria esta casi vacia
    output reg almost_full,         //Bandera de warning cuando la memoria esta casi llena
    output reg fifo_full,            //Bandera de memoria llena
    output reg fifo_empty);         //Bandera de memoria vacia

//Contador interno de celdas llenas 
    reg [PTR-1:0] counter;
    reg empty;
    reg [PTR-1:0] count;
    always @(*) begin
        if (reset) begin
            //Se realiza el control de la senal de almost_full, en el caso que hayan mas 
            //datos almacenados en memoria que lo que indica el umbral
            if (count >= full_threshold-1 & fifo_wr) begin
                almost_full = 1;       //Poner en alto la bandera de casi lleno si el contador es igual o mayor
            end
            else if (count >= full_threshold) begin
                almost_full = 1;
            end
            else begin
                almost_full = 0;       //Si el contador es menor que umbral, no enceder la bandera
            end
            //Se realiza el control para el caso que hayan menos datos almacenados en memoria
            //que los indicados por el umbral de vacio
            if (counter <= empty_threshold) begin
                almost_empty = 1;      //Si el contador es menor que el umbral de vacio, poner la bandera alto
            end
            else begin
                almost_empty = 0;      //Si el contador es mayor que el umbral de vacio, poner la bandera en bajo
            end
        end
        else begin
            almost_empty = 0;          //Valores default
            almost_full = 0;
        end
    end


    always @ (posedge clk) begin
        if (!reset) begin           // Valores default
            error <= 0;
            count <= 0;
        end 
        else begin                   
            //En esta etapa se realiza el control del error, asi como del contador que administra 
            //la cantidad de datos almacenados en memoria. Ademas se lleva el control de las senales 
            //de memoria llena o memoria vacia.
            if ((fifo_wr & ~fifo_rd & fifo_full) | (fifo_rd & !fifo_wr & empty)) begin        //condiciones
                error <= 1;             //Poner el error en alto si hay rebase de la memoria
            end
            
            else if (fifo_wr & ~fifo_rd & ~fifo_full) begin
                count <= count + 1;
                error <= 0;                     //Mantener el error en bajo
            end
            
            else if (fifo_rd & ~fifo_wr & ~empty) begin
                count <= count - 1;
                error <= 0;                     //Mantener el error en bajo
            end 
            else begin
                error <= error + 0;
            end
        end
        empty <= fifo_empty;
    end

    
    
    always @(*) begin
        if (reset) begin
            if (fifo_wr & count == 0) begin
                fifo_empty = 0;
            end
            else if (~fifo_wr & count == 0) begin
                fifo_empty = 1;
            end
            else if (fifo_wr & fifo_rd) begin
                fifo_empty = 0;
            end
            else if (fifo_rd & count == 1) begin
                fifo_empty = 1;
            end
            else if (~fifo_rd & count >= 1) begin
                fifo_empty = 0;
            end
            else fifo_empty = 0;
        end
        else fifo_empty = 0;
    end

    always @(*) begin
        if (reset) begin
            if (count == MEM_SIZE & fifo_wr) begin
                fifo_full = 1;             //Poner en alto la bandera de senal de lleno cuando el contador llegue al tamano de la memoria
            end 
            else begin
                fifo_full = 0;             //Poner la senal en bajo si no esta lleno
            end
        end
        else fifo_full = 0;
    end
endmodule