`include "memory.v"
`include "write_logic.v"
`include "read_logic.v"
`include "control_logic.v"

module fifo #(
	// Tamaño de cada celda de memoria, [9:8] destino [7:0] datos
    parameter MEM_SIZE = 8,
	// Tamaño de la memoria completa
    parameter WORD_SIZE = 10,
	// Cantidad de bits para referenciar la memoria completa
	// ptr = log2(mem_size)
    parameter PTR = 3
) (
    input clk,
    input reset,
	input fifo_wr,
    input fifo_rd,
	input [PTR-1:0] full_threshold,
    input [PTR-1:0] empty_threshold,
	input [WORD_SIZE-1:0] fifo_data_in,
	output error,
    output almost_empty,
    output almost_full,
    output fifo_full,
    output fifo_empty,
	output reg [WORD_SIZE-1:0] fifo_data_out,
);

	wire [WORD_SIZE-1:0] data_out_MM;
	wire pop;
	wire push;
	wire [PTR-1:0] rd_ptr;
	wire [PTR-1:0] wr_ptr;

	write_logic #(	.MEM_SIZE (MEM_SIZE), 
					.WORD_SIZE(WORD_SIZE), 
					.PTR(PTR)) write_log(	.clk			(clk),
					     					.reset			(reset),
											.fifo_wr		(fifo_wr),
					     					.fifo_rd		(fifo_rd),
					     					.fifo_full		(fifo_full),
											.push			(push),
					     					.wr_ptr			(wr_ptr)
										);

	read_logic #(	.MEM_SIZE (MEM_SIZE), 
					.WORD_SIZE(WORD_SIZE), 
					.PTR(PTR)) read_log(	.clk			(clk),
					   						.reset			(reset),
											.fifo_rd		(fifo_rd),
					   						.fifo_wr		(fifo_wr),
					   						.fifo_empty		(fifo_empty),
											.pop			(pop),
											.rd_ptr			(rd_ptr)
										);

	control_logic #(.MEM_SIZE (MEM_SIZE), 
					.WORD_SIZE(WORD_SIZE), 
					.PTR(PTR)) control_log(	.clk			(clk),
											.reset_L		(reset),
											.fifo_wr		(fifo_wr),
											.fifo_rd		(fifo_rd),
											.full_threshold	(full_threshold),
						 					.empty_threshold(empty_threshold),
											.error			(error),
						 					.almost_empty	(almost_empty),
						 					.almost_full	(almost_full),
						 					.fifo_full		(fifo_full),
						 					.fifo_empty		(fifo_empty)
										);

	memory #(	.MEM_SIZE (MEM_SIZE), 
				.WORD_SIZE(WORD_SIZE), 
				.PTR_L(PTR_L)) memoria(		.clk			(clk),
											.reset			(reset),
											.push			(push),
				      						.pop			(pop),
											.wr_ptr			(wr_ptr),
											.rd_ptr			(rd_ptr),
											.data_in_MM		(fifo_data_in),
											.data_out_MM	(data_out_MM)
									);

	always @(*) begin
    	fifo_data_out <= data_out_MM;
	end
endmodule
