all:  all_contador all_arbitro1 all_arbitro2
all_contador: contador cambio_contador simular_contador 
all_arbitro1: arbitro1 cambio_arbitro1 simular_arbitro1
all_arbitro2: arbitro2 cambio_arbitro2 simular_arbitro2

contador:
	yosys -s contador.ys
	
arbitro1:
	yosys -s arbitro1.ys

arbitro2: 
	yosys -s arbitro2.ys
	
cambio_contador:
	sed -i 's/contador/contador_sint/g' contador_sint.v 
	sed -i 's/cuenta/cuenta_sint/g' contador_sint.v
	sed -i 's/contador_sint_4/contador_4_sint/g' contador_sint.v
	sed -i 's/valid/valid_sint/g' contador_sint.v
	
cambio_arbitro1:
	sed -i 's/arbitro1/arbitro1_sint/g' arbitro1_sint.v
	sed -i 's/fifo_data_out_cond/fifo_data_out_sint/g' arbitro1_sint.v
	sed -i 's/fifos_push/fifos_push_sint/g' arbitro1_sint.v
	sed -i 's/fifos_pop/fifos_pop_sint/g' arbitro1_sint.v

cambio_arbitro2:
	sed -i 's/arbitro2/arbitro2_sint/g' arbitro2_sint.v
	sed -i 's/data_out_arb/data_out_arb_sint/g' arbitro2_sint.v
	sed -i 's/pop/pop_sint/g' arbitro2_sint.v
	sed -i 's/push/push_sint/g' arbitro2_sint.v 

simular_contador:
	iverilog -o prueba1 BancoPrueba_contador.v 
	vvp prueba1
	gtkwave contador.vcd
	
simular_arbitro1:
	iverilog -o prueba BancoPrueba_arbitro1.v
	vvp prueba
	gtkwave arbitro1.vcd

simular_arbitro2:
	iverilog -o prueba BancoPrueba_arbitro2.v
	vvp prueba
	gtkwave arbitro2.vcd