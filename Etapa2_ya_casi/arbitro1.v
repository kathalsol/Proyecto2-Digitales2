module arbitro1 #(
	// Tamaño de cada celda de memoria, [11:10] clase [9:8] destino [7:0] datos
    parameter WORD_SIZE = 12
) (
    input clk,
    input reset,
    input [3:0] fifos_almost_full,
    input [3:0] fifos_empty,
    input [WORD_SIZE-1:0] fifo_data_in0,
    input [WORD_SIZE-1:0] fifo_data_in1,
    input [WORD_SIZE-1:0] fifo_data_in2,
    input [WORD_SIZE-1:0] fifo_data_in3,
    output reg [3:0] fifos_push,
    output reg [3:0] fifos_pop,
    output reg [WORD_SIZE-1:0] fifo_data_out_cond
);  
    reg [WORD_SIZE-1:0] data_intermediate;
    reg [1:0] dest;
    reg [3:0] prioridad;

    always @(posedge clk) begin
        if (!reset) begin
            fifos_pop <= 0;
            fifos_push <= 0;
            fifo_data_out_cond <= 0;
            data_intermediate <= 0;
            prioridad <= 0;
        end
        else begin
            if (fifos_almost_full != 4'b1111) begin
                if (fifos_empty == 4'b1111) begin
                    fifos_pop <= 0;
                    fifos_push <= 0;
                end
                else begin
                    fifos_push <= 0;
                    fifos_pop <= 0;
                    case (prioridad)
                        4'b0000: begin
                            fifos_pop[0] <= 1;
                            data_intermediate <= fifo_data_in0;
                            dest <= fifo_data_in0[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b0001: begin
                            fifos_pop[0] <= 1;
                            data_intermediate <= fifo_data_in0;
                            dest <= fifo_data_in0[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b0010: begin
                            fifos_pop[0] <= 1;
                            data_intermediate <= fifo_data_in0;
                            dest <= fifo_data_in0[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b011: begin
                            fifos_pop[0] <= 1;
                            data_intermediate <= fifo_data_in0;
                            dest <= fifo_data_in0[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b0100: begin
                            fifos_pop[1] <= 1;
                            data_intermediate <= fifo_data_in1;
                            dest <= fifo_data_in1[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b0101: begin
                            fifos_pop[1] <= 1;
                            data_intermediate <= fifo_data_in1;
                            dest <= fifo_data_in1[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b0110: begin
                            fifos_pop[1] <= 1;
                            data_intermediate <= fifo_data_in1;
                            dest <= fifo_data_in1[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b0111: begin
                            fifos_pop[2] <= 1;
                            data_intermediate <= fifo_data_in2;
                            dest <= fifo_data_in2[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b1000: begin
                            fifos_pop[2] <= 1;
                            data_intermediate <= fifo_data_in2;
                            dest <= fifo_data_in2[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b1001: begin
                            fifos_pop[3] <= 1;
                            data_intermediate <= fifo_data_in3;
                            dest <= fifo_data_in3[WORD_SIZE-3:WORD_SIZE-4];
                            prioridad <= prioridad + 1;
                        end
                        4'b1000: begin
                            prioridad <= 0;
                            data_intermediate <= 0;
                            dest <= 0;
                        end
                    endcase
                    case (dest)
                        2'b00: begin
                            if (fifos_almost_full[0] == 1) fifos_push[0] <= 0;
                            else fifos_push[0] <= 1;
                        end
                        2'b01: begin
                            if (fifos_almost_full[1] == 1) fifos_push[1] <= 0;
                             else fifos_push[1] <= 1;
                        end
                        2'b10: begin
                            if (fifos_almost_full[2] == 1) fifos_push[2] <= 0;
                            else fifos_push[2] <= 1;
                        end
                        2'b11: begin
                            if (fifos_almost_full[3] == 1) fifos_push[3] <= 0;
                            else fifos_push[3] <= 1;
                        end
                    endcase
                    fifo_data_out_cond <= data_intermediate;
                end
            end
            else begin
                fifos_pop <= 0;
                fifos_push <= 0;
            end
        end
    end
endmodule