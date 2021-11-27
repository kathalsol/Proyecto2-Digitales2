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

    reg [3:0] prioridad;
    reg do_pop;
    reg do_push;

    always @(posedge clk) begin
        if (!reset) begin
            fifos_pop <= 0;
            fifos_push <= 0;
            fifo_data_out_cond <= 0;
            prioridad <= 0;
            do_pop <= 0;
            do_push <= 0;
        end
        else begin
            if (fifos_empty == 4'b1111) begin
                fifos_pop <= 0;
                fifos_push <= 0;
                do_pop <= 0;
                fifo_data_out_cond <= 0;
            end
            else begin
                case (fifos_almost_full)
                4'b0000: begin
                    do_pop <= 1;
                    if (do_pop) fifos_pop <= 1;
                    else fifos_pop <= 0;
                end
                4'b0001: begin
                    fifos_push <= 0;
                    do_pop <= 1;
                    fifos_pop <= 0;
                end
                4'b0010: begin
                    fifos_push <= 0;
                    do_pop <= 1;
                    fifos_pop <= 0;
                end
                4'b0100: begin
                    fifos_push <= 0;
                    do_pop <= 0;
                    fifos_pop <= 0;
                end
                4'b1000: begin
                    fifos_push <= 0;
                    do_pop <= 0;
                    fifos_pop <= 0;
                end
            endcase
            end
            if ((do_push & do_pop) | (do_push & fifos_pop != 0) | (do_pop & fifos_pop != 0)) begin
                fifos_pop <= 0;
                case (prioridad)
                    4'b0000: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[0]) begin
                                if (fifos_empty[1]) begin
                                    if (fifos_empty[2]) begin
                                        fifos_pop[3] <= 1;
                                        prioridad <= 4'b1001;
                                    end
                                    else begin
                                        fifos_pop[2] <= 1;
                                        prioridad <= 4'b0111;
                                    end
                                end
                                else begin
                                    fifos_pop[1] <= 1;
                                    prioridad <= 4'b0100;
                                end
                            end
                            else begin
                                fifos_pop[0] <= 1;
                                prioridad <= prioridad + 1;
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in0[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                        endcase
                    end
                    4'b0001: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[0]) begin
                                if (fifos_empty[1]) begin
                                    if (fifos_empty[2]) begin
                                        fifos_pop[3] <= 1;
                                        prioridad <= 4'b1001;
                                    end
                                    else begin
                                        fifos_pop[2] <= 1;
                                        prioridad <= 4'b0111;
                                    end
                                end
                                else begin
                                    fifos_pop[1] <= 1;
                                    prioridad <= 4'b0100;
                                end
                            end
                            else begin
                                fifos_pop[0] <= 1;
                                prioridad <= prioridad + 1;
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in0[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                        endcase
                    end
                    4'b0010: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[0]) begin
                                if (fifos_empty[1]) begin
                                    if (fifos_empty[2]) begin
                                        fifos_pop[3] <= 1;
                                        prioridad <= 4'b1001;
                                    end
                                    else begin
                                        fifos_pop[2] <= 1;
                                        prioridad <= 4'b0111;
                                    end
                                end
                                else begin
                                    fifos_pop[1] <= 1;
                                    prioridad <= 4'b0100;
                                end
                            end
                            else begin
                                fifos_pop[0] <= 1;
                                prioridad <= prioridad + 1;
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in0[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                        endcase
                    end
                    4'b0011: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[1]) begin
                                if (fifos_empty[2]) begin
                                    if (fifos_empty[3]) begin
                                        fifos_pop[0] <= 1;
                                        prioridad <= 0;
                                    end
                                    else begin
                                        fifos_pop[3] <= 1;
                                        prioridad <= 4'b1001;
                                    end
                                end
                                else begin
                                    fifos_pop[2] <= 1;
                                    prioridad <= 4'b0111;
                                end
                            end
                            else begin
                                fifos_pop[1] <= 1;
                                prioridad <= prioridad + 1;
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in0[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in0;
                            end
                        endcase
                    end
                    4'b0100: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[1]) begin
                                if (fifos_empty[2]) begin
                                    if (fifos_empty[3]) begin
                                        fifos_pop[0] <= 1;
                                        prioridad <= 0;
                                    end
                                    else begin
                                        fifos_pop[3] <= 1;
                                        prioridad <= 4'b1001;
                                    end
                                end
                                else begin
                                    fifos_pop[2] <= 1;
                                    prioridad <= 4'b0111;
                                end
                            end
                            else begin
                                fifos_pop[1] <= 1;
                                prioridad <= prioridad + 1;
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in1[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                        endcase
                    end
                    4'b0101: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[1]) begin
                                if (fifos_empty[2]) begin
                                    if (fifos_empty[3]) begin
                                        fifos_pop[0] <= 1;
                                        prioridad <= 0;
                                    end
                                    else begin
                                        fifos_pop[3] <= 1;
                                        prioridad <= 4'b1001;
                                    end
                                end
                                else begin
                                    fifos_pop[2] <= 1;
                                    prioridad <= 4'b0111;
                                end
                            end
                            else begin
                                fifos_pop[1] <= 1;
                                prioridad <= prioridad + 1;
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in1[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                        endcase
                    end
                    4'b0110: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[2]) begin
                                if (fifos_empty[3]) begin
                                    if (fifos_empty[0]) begin
                                        fifos_pop[1] <= 1;
                                        prioridad <= 4'b0100;
                                    end
                                    else begin
                                        fifos_pop[0] <= 1;
                                        prioridad <= 0;
                                    end
                                end
                                else begin
                                    fifos_pop[3] <= 1;
                                    prioridad <= 4'b1001;
                                end
                            end
                            else begin
                                fifos_pop[2] <= 1;
                                prioridad <= prioridad + 1;
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in1[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in1;
                            end
                        endcase
                    end
                    4'b0111: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[2]) begin
                                if (fifos_empty[3]) begin
                                    if (fifos_empty[0]) begin
                                        fifos_pop[1] <= 1;
                                        prioridad <= 4'b0100;
                                    end
                                    else begin
                                        fifos_pop[0] <= 1;
                                        prioridad <= 0;
                                    end
                                end
                                else begin
                                    fifos_pop[3] <= 1;
                                    prioridad <= 4'b1001;
                                end 
                            end
                            else begin
                                fifos_pop[2] <= 1;
                                prioridad <= prioridad + 1;
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in2[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in2;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in2;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in2;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in2;
                            end
                        endcase
                    end
                    4'b1000: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[3]) begin
                                if (fifos_empty[0]) begin
                                    if (fifos_empty[1]) begin
                                        fifos_pop[2] <= 1;
                                        prioridad <= 4'b0111;
                                    end
                                    else begin
                                        fifos_pop[1] <= 1;
                                        prioridad <= 4'b0100;
                                    end
                                end
                                else begin
                                    fifos_pop[0] <= 1;
                                    prioridad <= 0;
                                end 
                            end
                            else begin
                                fifos_pop[3] <= 1;
                                prioridad <= prioridad + 1;
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in2[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in2;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in2;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in2;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in2;
                            end
                        endcase
                    end
                    4'b1001: begin
                        if (fifos_almost_full == 4'b1000) begin
                            prioridad <= prioridad + 0;
                        end
                        else begin
                            if (fifos_empty[0] == 1) begin
                                if (fifos_empty[1]) begin
                                    if (fifos_empty[2]) begin
                                        if (fifos_empty[3]) begin
                                            fifos_pop[3] <= 0;
                                        end
                                        else fifos_pop[3] <= 1;
                                        prioridad <= 4'b1001;
                                    end
                                    else begin
                                        fifos_pop[2] <= 1;
                                        prioridad <= 4'b0111;
                                    end
                                end
                                else begin
                                    fifos_pop[1] <= 1;
                                    prioridad <= 4'b0100;
                                end
                            end
                            
                            else begin
                                if (fifos_almost_full == 4'b0100) begin
                                    fifos_pop[0] <= 0;
                                    prioridad <= 0;
                                end
                                else begin
                                    fifos_pop[0] <= 1;
                                    prioridad <= 0;
                                end    
                            end
                        end
                        fifos_push <= 0;
                        case (fifo_data_in3[WORD_SIZE-3:WORD_SIZE-4])
                            2'b00: begin
                                fifos_push[0] <= 1;
                                fifo_data_out_cond <= fifo_data_in3;
                            end
                            2'b01: begin
                                fifos_push[1] <= 1;
                                fifo_data_out_cond <= fifo_data_in3;
                            end
                            2'b10: begin
                                fifos_push[2] <= 1;
                                fifo_data_out_cond <= fifo_data_in3;
                            end
                            2'b11: begin
                                fifos_push[3] <= 1;
                                fifo_data_out_cond <= fifo_data_in3;
                            end
                        endcase
                    end
                endcase
            end
            else begin
                fifo_data_out_cond <= 0;
                fifos_push <= 0;
            end
            do_push <= do_pop;
        end
    end
endmodule