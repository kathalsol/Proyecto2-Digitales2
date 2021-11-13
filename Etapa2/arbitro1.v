module arbitro2 #(
    // Tamaño de la memoria completa
    parameter MEM_SIZE = 8,
	// Tamaño de cada celda de memoria, [11:10] clase [9:8] destino [7:0] datos
    parameter WORD_SIZE = 12,
	// Cantidad de bits para referenciar la memoria completa
	// ptr = log2(MEM_SIZE)
    parameter PTR = 3,
    // Cantidad de FIFOS de la etapa de entrada
    parameter FIFO_UNITS = 4,
    // Cantidad de bits necesarios para acceder cada FIFO
    // INDEX = log2(FIFO_UNITS)
    parameter INDEX = 2
) (
    c
);
    integer i;
    reg [1:0] class;

    always @(posedge clk) begin
        if (!reset) begin
            pop <= 0;
            push <= 0;
            cuenta_4 <= 0;
            class <= 0;
        end
        else begin
            if (fifo_empty) pop <= 0;
            else begin
                pop <= 1;
                
			end
		end
    end
    always  begin
    class <= data_in_arb[WORD_SIZE-1:WORD_SIZE-2];
                case (param)
                    : 
                    default: 
                endcase
                for (i = 0; i < Word_Num; i = i+1)
endmodule