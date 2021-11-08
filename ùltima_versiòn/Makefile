all:  memory  fifo	cambio simular

memory:
	yosys -s memory.ys
	
fifo:
	yosys -s fifo.ys
	
cambio:
	sed -i 's/control_logic/control_logic_sint/g' fifo_sint.v
	sed -i 's/memory/memory_sint/g' memory_sint.v
	sed -i 's/data_out_MM/data_out_MM_sint/g' memory_sint.v
	sed -i 's/read_logic/read_logic_sint/g' fifo_sint.v
	sed -i 's/write_logic/write_logic_sint/g' fifo_sint.v
	sed -i 's/fifo/fifo_sint/g' fifo_sint.v
	sed -i 's/error/error_sint/g' fifo_sint.v
	sed -i 's/almost_empty/almost_empty_sint/g' fifo_sint.v
	sed -i 's/almost_full/almost_full_sint/g' fifo_sint.v
	sed -i 's/fifo_full/fifo_full_sint/g' fifo_sint.v
	sed -i 's/fifo_empty/fifo:_empty_sint/g' fifo_sint.v
	sed -i 's/fifo_data_out/fifo_data_out_sint/g' fifo_sint.v
	
simular:
	iverilog -o prueba BancoPrueba_fifo.v
	vvp prueba
	gtkwave memory.vcd
	iverilog -o prueba1 BancoPrueba_memory.v 
	vvp prueba1