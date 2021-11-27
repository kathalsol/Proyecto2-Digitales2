module maquina_estado #(
	// Tamaño de la memoria completa
    // parameter MEM_SIZE = 8,
	// Tamaño de cada celda de memoria, [11:10] clase [9:8] destino [7:0] datos
    // parameter WORD_SIZE = 12,
	// Cantidad de bits para referenciar la memoria completa
	// ptr = log2(MEM_SIZE)
    parameter PTR = 3
) (
	input clk,
	input reset,
    input init,
    input [PTR-1:0] full_threshold,
    input [PTR-1:0] empty_threshold,
    input [8:0] fifos_empty, 
	output reg [PTR-1:0] fifos_full_threshold,
    output reg [PTR-1:0] fifos_empty_threshold,
    output reg idle,
    output reg [1:0] state
	
);
	parameter RESET = 'd0;   
	parameter INIT = 'd1;       // Estado luego de reset
	parameter IDLE = 'd2;       // Si no esta vacio pasa a Active
	parameter ACTIVE = 'd3;     //Si esta vacio

	always @(posedge clk) begin
		if (!reset) begin
			state <= RESET;
            idle <= 0;
            fifos_empty_threshold <= 0;
            fifos_full_threshold <= 3'b0;
		end
		else begin
			case (state)
				RESET:
                begin
                    state <= INIT;
                    idle <= 0;
                end
                INIT:
				begin
                    if (init) begin
                        state <= INIT;
                        idle <= 0;
                        fifos_full_threshold <= full_threshold;
                        fifos_empty_threshold <= empty_threshold;
                    end
                    else begin
                        state <= IDLE;
                        idle <= 1;
                    end
				end
				IDLE:
				begin
                    if (init) begin
                        state <= INIT;
                        idle <= 0;
                    end
                    else begin
                        if (fifos_empty == 'b111111111) begin
                            state <= IDLE;
                            idle <= 1;
                        end 
                        else begin
                            state <= ACTIVE;
                            idle <= 0;
                        end
                    end
				end
				ACTIVE:
				begin
					if (fifos_empty == 'b111111111) begin
                        state <= IDLE;
                        idle <= 1;
                    end
                    else begin
                        state <= ACTIVE;
                        idle <= 0;
                    end
                end
			endcase
		end
	end
endmodule
