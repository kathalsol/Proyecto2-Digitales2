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
    reg do_push;
    reg [1:0] dest;
    reg [3:0] prioridad;

    always @(posedge clk) begin
        if (!reset) begin
            fifos_pop <= 0;
            fifos_push <= 0;
            fifo_data_out_cond <= 0;
            data_intermediate <= 0;
            do_push <= 0; 
            prioridad <= 0;
        end
        else begin
            if (fifos_empty == 4'b1111) begin
                fifos_pop <= 0;
                fifos_push <= 0;
                fifo_data_out_cond <= 0;
                do_push <= 0;
            end
            else begin
                if (fifos_almost_full[3] | fifos_almost_full[2] | fifos_almost_full[1] | fifos_almost_full[0]) begin
                    fifos_pop <= 0;
                    fifos_push <= 0;
                    fifo_data_out_cond <= 0;
                end
                else begin
                    if (fifos_empty[0]) begin
                        if (fifos_empty[1]) begin
                            if (fifos_empty[2]) begin
                                if (fifos_empty[3]) begin
                                    prioridad <= 4'b1010;
                                    fifos_push <= 0;
                                end
                                else begin
                                    prioridad <= 4'b1001;
                                    fifos_pop[3] <= 1;
                                    fifos_push <= 0;
                                end
                            end
                            else begin
                                prioridad <= 4'b0111;
                                fifos_pop[2] <= 1;
                                fifos_push <= 0;
                            end
                        end
                        else begin
                            prioridad <= 4'b0100;
                            fifos_pop[1] <= 1;
                            fifos_push <= 0;
                        end
                    end
                    else begin
                        fifos_pop[0] <= 1;
                        fifos_push <= 0;
                    end
                end
                if (fifos_pop[0] | fifos_pop[1] | fifos_pop[2] | fifos_pop[3]) begin
                    fifos_pop <= 0;
                    case (prioridad)
                        4'b0000: begin
                            fifos_pop[0] <= 1;
                            data_intermediate <= fifo_data_in0;
                            prioridad <= prioridad + 1;
                            do_push <= 1;
                        end
                        4'b0001: begin
                            fifos_pop[0] <= 1;
                            data_intermediate <= fifo_data_in0;
                            prioridad <= prioridad + 1;
                        end
                        4'b0010: begin
                            fifos_pop[0] <= 1;
                            data_intermediate <= fifo_data_in0;
                            prioridad <= prioridad + 1;
                        end
                        4'b0011: begin
                            fifos_pop[1] <= 1;
                            data_intermediate <= fifo_data_in0;
                            prioridad <= prioridad + 1;
                        end
                        4'b0100: begin
                            fifos_pop[1] <= 1;
                            data_intermediate <= fifo_data_in1;
                            prioridad <= prioridad + 1;
                        end
                        4'b0101: begin
                            fifos_pop[1] <= 1;
                            data_intermediate <= fifo_data_in1;
                            prioridad <= prioridad + 1;
                        end
                        4'b0110: begin
                            fifos_pop[2] <= 1;
                            data_intermediate <= fifo_data_in1;
                            prioridad <= prioridad + 1;
                        end
                        4'b0111: begin
                            fifos_pop[2] <= 1;
                            data_intermediate <= fifo_data_in2;
                            prioridad <= prioridad + 1;
                        end
                        4'b1000: begin
                            fifos_pop[3] <= 1;
                            data_intermediate <= fifo_data_in2;
                            prioridad <= prioridad + 1;
                        end
                        4'b1001: begin
                            fifos_pop[0] <= 1;
                            data_intermediate <= fifo_data_in3;
                            prioridad <= 0;
                        end
                        4'b1010: begin
                            fifos_pop[0] <= 1;
                            prioridad <= 0;
                        end
                    endcase
                end
            end
            if (do_push) begin
                case (dest)
                    2'b00: begin
                        fifos_push[0] <= 1;
                        fifo_data_out_cond <= data_intermediate;
                    end
                    2'b01: begin
                        fifos_push[1] <= 1;
                        fifo_data_out_cond <= data_intermediate;
                    end
                    2'b10: begin
                        fifos_push[2] <= 1;
                        fifo_data_out_cond <= data_intermediate;
                    end
                    2'b11: begin
                        fifos_push[3] <= 1;
                        fifo_data_out_cond <= data_intermediate;
                    end
                endcase
            end
            else fifo_data_out_cond <= 0;
        end
    end

    always @(*) begin
        dest = data_intermediate[WORD_SIZE-3:WORD_SIZE-4];
    end
endmodule