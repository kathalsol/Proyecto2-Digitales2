all_maquina:  maquina cambio_maquina simular_maquina

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
