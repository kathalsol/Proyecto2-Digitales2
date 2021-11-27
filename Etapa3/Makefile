all_maquina:  maquina cambio_maquina simular_maquina

all_transaction: transaction cambio_transaction simular_transaction

maquina:
	yosys -s maquina.ys

cambio_maquina:
	sed -i 's/maquina_estado/maquina_estado_sint/g' maquina_estado_sint.v
	sed -i 's/fifos_full_threshold/fifos_full_threshold_sint/g' maquina_estado_sint.v
	sed -i 's/fifos_empty_threshold/fifos_empty_threshold_sint/g' maquina_estado_sint.v
	sed -i 's/state/state_sint/g' maquina_estado_sint.v
	sed -i 's/idle/idle_sint/g' maquina_estado_sint.v

simular_maquina:
	iverilog -o prueba1 BancoPrueba_maquina.v 
	vvp prueba1
	gtkwave maquina.vcd
	
transaction:
	yosys -s transaction.ys

cambio_transaction:
	sed -i 's/write_logic/writed_logic_sint/g' transaction_sint.v
	sed -i 's/read_logic/read_logic_sint/g' transaction_sint.v
	sed -i 's/control_logic/control_logic_sint/g' transaction_sint.v
	sed -i 's/memory/memory_sint/g' transaction_sint.v
	sed -i 's/maquina_estado/maquina_estado_sint/g' transaction_sint.v
	sed -i 's/arbitro1/arbitro1_sint/g' transaction_sint.v
	sed -i 's/arbitro2/arbitro2_sint/g' transaction_sint.v
	sed -i 's/data_out_S0/data_out_S0_sint/g' transaction_sint.v
	sed -i 's/data_out_S1/data_out_S1_sint/g' transaction_sint.v
	sed -i 's/data_out_S2/data_out_S2_sint/g' transaction_sint.v
	sed -i 's/data_out_S3/data_out_S3_sint/g' transaction_sint.v
	sed -i 's/valid/valid_sint/g' transaction_sint.v
	sed -i 's/cuenta/cuenta_sint/g' transaction_sint.v
	sed -i 's/contador_4/contador_4_sint/g' transaction_sint.v
	sed -i '2958 s/contador/contador_sint/1' transaction_sint.v
	sed -i '4763 s/fifo/fifo_sint/1' transaction_sint.v
	sed -i 's/transaction/transaction_sint/g' transaction_sint.v
	sed -i 's/state/state_sint/g' transaction_sint.v
	sed -i '11267 s/contador/contador_sint/1' transaction_sint.v
	sed -i '11283 s/fifo/fifo_sint/1' transaction_sint.v
	sed -i '11299 s/fifo/fifo_sint/1' transaction_sint.v
	sed -i '11315 s/fifo/fifo_sint/1' transaction_sint.v
	sed -i '11331 s/fifo/fifo_sint/1' transaction_sint.v
	sed -i '11347 s/fifo/fifo_sint/1' transaction_sint.v
	sed -i '11363 s/fifo/fifo_sint/1' transaction_sint.v
	sed -i '11379 s/fifo/fifo_sint/1' transaction_sint.v
	sed -i '11395 s/fifo/fifo_sint/1' transaction_sint.v
	sed -i '11411 s/fifo/fifo_sint/1' transaction_sint.v

simular_transaction:
	iverilog -o prueba1 BancoPrueba_transaction.v 
	vvp prueba1
	gtkwave transaction1.vcd

