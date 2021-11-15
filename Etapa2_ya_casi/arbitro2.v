module arbitro2 #(
	// Tamaño de cada celda de memoria, [11:10] clase [9:8] destino [7:0] datos
    parameter WORD_SIZE = 12

) (
    input clk,
    input reset,
    input [WORD_SIZE-1:0] data_in_arb,
    input fifo_empty,
    input [3:0] fifos_almost_full,
    output reg [WORD_SIZE-1:0] data_out_arb,
    output reg pop,
    output reg [3:0] push,
    output reg [4:0] cuenta_4
);
    reg [1:0] class;

    always @(posedge clk) begin
        if (!reset) begin
            pop <= 0;
            push <= 0;
            cuenta_4 <= 0;
            data_out_arb <= 0;
        end
        else begin
            if (fifos_almost_full != 4'b1111) begin
                if (fifo_empty) begin
                    pop <= 0;
                    push <= 0;
                end
                else begin
                    pop <= 1;
                    class <= data_in_arb[WORD_SIZE-1:WORD_SIZE-2];
                    push <= 0;
                    case (class)
                        2'b00: begin
                            if (fifos_almost_full[0] == 1) push[0] <= 0;
                            else begin
                                push[0] <= 1;
                                cuenta_4 <= cuenta_4 + 1;
                            end
                        end
                        2'b01: begin
                            if (fifos_almost_full[1] == 1) push[1] <= 0;
                             else begin
                                push[1] <= 1;
                                cuenta_4 <= cuenta_4 + 1;
                            end
                        end
                        2'b10: begin
                            if (fifos_almost_full[2] == 1) push[2] <= 0;
                            else begin
                                push[2] <= 1;
                                cuenta_4 <= cuenta_4 + 1;
                            end
                        end
                        2'b11: begin
                            if (fifos_almost_full[3] == 1) push[3] <= 0;
                            else begin
                                push[3] <= 1;
                                cuenta_4 <= cuenta_4 + 1;
                            end
                        end
                    endcase
                    data_out_arb <= data_in_arb;
                end
            end
            else begin
                pop <= 0;
                push <= 0;
            end
		end
    end
endmodule