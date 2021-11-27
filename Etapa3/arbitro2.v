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
    output reg [3:0] push
);
    reg [1:0] class;

    always @(posedge clk) begin
        if (!reset) begin
            pop <= 0;
            push <= 0;
            data_out_arb <= 0;
        end
        else begin
            if (fifo_empty) begin
                pop <= 0;
                push <= 0;
                data_out_arb <= 0;
            end
            else begin
                if (fifos_almost_full[3] | fifos_almost_full[2] | fifos_almost_full[1] | fifos_almost_full[0]) begin
                    pop <= 0;
                    push <= 0;
                    data_out_arb <= 0;
                end
                else begin
                    if (fifo_empty) pop <= 0; 
                    else pop <= 1;
                    push <= 0;
                end
            end
            if (pop) begin
                case (class)
                    2'b00: begin
                        push[0] <= 1;
                        data_out_arb <= data_in_arb;
                    end
                    2'b01: begin
                        push[1] <= 1;
                        data_out_arb <= data_in_arb;
                    end
                    2'b10: begin
                        push[2] <= 1;
                        data_out_arb <= data_in_arb;
                    end
                    2'b11: begin
                        push[3] <= 1;
                        data_out_arb <= data_in_arb;
                    end
                endcase
            end    
            else data_out_arb <= 0;
        end
    end

    always @(*) begin
        class = data_in_arb[WORD_SIZE-1:WORD_SIZE-2];
    end
endmodule