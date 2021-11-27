module Probador_transaction #(
    // Tamaño de la memoria completa
    parameter MEM_SIZE = 8,
	// Tamaño de cada celda de memoria, [11:10] clase [9:8] destino [7:0] datos
    parameter WORD_SIZE = 12,
	// Cantidad de bits para referenciar la memoria completa
	// ptr = log2(MEM_SIZE)
    parameter PTR = 3,
    // Cantidad de FIFOS de la etapa de salida
    // parameter FIFO_UNITS = 4,
    // Cantidad de bits necesarios para acceder cada FIFO
    // INDEX = log2(FIFO_UNITS)
    parameter INDEX = 2
) (
    //inputs
    output reg clk,
    output reg reset,
    output reg init,
    output reg [PTR-1:0] full_threshold,
    output reg [PTR-1:0] empty_threshold,
    output reg probador_push,
    output reg [WORD_SIZE-1:0] data_in,
    output reg [3:0] probador_pop,
    output reg [1:0] idx,
    output reg req,
    
    // outputs
    input [WORD_SIZE-1:0] data_out_S0,
    input [WORD_SIZE-1:0] data_out_S1,
    input [WORD_SIZE-1:0] data_out_S2,
    input [WORD_SIZE-1:0] data_out_S3,
    input valid,
    input [4:0] cuenta,
    input [6:0] contador_4,
    input [1:0] state,  
    input [WORD_SIZE-1:0] data_out_S0_sint,
    input [WORD_SIZE-1:0] data_out_S1_sint,
    input [WORD_SIZE-1:0] data_out_S2_sint,
    input [WORD_SIZE-1:0] data_out_S3_sint,
    input valid_sint,
    input [4:0] cuenta_sint,
    input [6:0] contador_4_sint,
    input [1:0] state_sint
);
	initial clk = 0;
	always #1 clk = ~clk;


    // PRUEBA 1

    /* 1) Se saca el bloque de RESET, manteniendo  el  estado  de INIT  (señal init). 

       2) Modifique 2 veces los umbrales altos y bajos de los para todos. Libere la señal init.
      
       3) Provoque un Almost Full en todos los FIFOS de salida (son el mismo umbral bajo y
       alto de salida, el árbitro no le permitirá hacerlo de forma simultánea. Desde el probador,
       haga la menor cantidad de POPs. Desde el probador, haga la menor cantidad  de POPs.
       Verifique que las palabras que salieron son las mismas que entraron y que salieron por 
       la salida correcta en prioridad correcta.

       4) Provoque un Almost Full en todos los FIFOs de entrada. Luego usando POPs del probador 
       deje todos los FIFOs vacíos. Verifique que las palabras que salieron son las mismas que
       entraron y que salieron por la salida correcta en la prioridad correcta.

       5) Lea los contadores de palabras. El contador 4 debe tener el mismo valor que la suma de
       los contadores 0, 1, 2 y 3. */
    
	initial begin
		$dumpfile ("transaction1.vcd");
		$dumpvars();

        // Bloque de reset
        reset <= 0;
        init <= 0;
        full_threshold <= 3'b110;
        empty_threshold <= 3'b010;
        probador_pop <= 0;
        probador_push <= 0;
        data_in <= 0;
        idx <= 0;
        req <= 0;
        
        // Se sale del bloque de reset
        @(posedge clk);
        reset <= 1; 

        // Se hace la primera modificación de los umbrales
        @(posedge clk);
        init <= 1;

        // Se hace la segunda modificación de los umbrales
        @(posedge clk);
        full_threshold <= 3'b111;
        empty_threshold <= 3'b001;

        // Pasa al estado IDLE
        @(posedge clk);
        init <= 0;
        
        // Para Almost full en los fifos de salida
        @(posedge clk);
        probador_push <= 1;
        data_in <= 12'b000011110101;

        @(posedge clk);
        data_in <= 12'b010110101101;

        @(posedge clk);
        data_in <= 12'b101011001010;

        @(posedge clk);
        data_in <= 12'b111100110011;

        @(posedge clk);
        data_in <= 12'b000011001011;

        @(posedge clk);
        data_in <= 12'b010110110011;

        @(posedge clk);
        data_in <= 12'b101011110000;

        @(posedge clk);
        data_in <= 12'b111111110011;

        @(posedge clk);
        data_in <= 12'b000011000011;

        @(posedge clk);
        data_in <= 12'b010110101010;

        @(posedge clk);
        data_in <= 12'b101010110011;

        @(posedge clk);
        data_in <= 12'b111111111111;

        @(posedge clk);
        data_in <= 12'b000001010101;

        @(posedge clk);
        data_in <= 12'b010111001100;

        @(posedge clk);
        data_in <= 12'b101001010101;

        @(posedge clk);
        data_in <= 12'b111111111000;

        @(posedge clk);
        data_in <= 12'b000001011001;

        @(posedge clk);
        data_in <= 12'b010101010111;

        @(posedge clk);
        data_in <= 12'b101011110000;

        @(posedge clk);
        data_in <= 12'b111111001100;

        @(posedge clk);
        data_in <= 12'b000001010011;

        @(posedge clk);
        data_in <= 12'b010100001111;

        @(posedge clk);
        data_in <= 12'b101011110101;

        @(posedge clk);
        data_in <= 12'b111111110000;

        // Se provoca Almost_full en S0
        @(posedge clk);
        data_in <= 12'b000000110101;

        // Se provoca Almost_full en S1
        @(posedge clk);
        data_in <= 12'b010100110101;
        
        // Se provoca Almost_full en S2
        @(posedge clk);
        data_in <= 12'b101000000010;
        
        // Se provoca Almost_full en S3
        @(posedge clk);
        data_in <= 12'b111111110110;
        
        @(posedge clk);
        data_in <= 12'b000000111000;  

        // Se hace pop a S0
        @(posedge clk);
        data_in <= 12'b010101100011;
        probador_pop <= 4'b0001;
        
        // Se hace pop a S1
        @(posedge clk);
        probador_pop <= 4'b0010;
        data_in <= 12'b101010110010;
        
        // Se hace pop a S2
        @(posedge clk);
        probador_pop <= 4'b0100;
        data_in <= 12'b111100111100;

        // SE VAN A LLENAR LOS FIFOS DE ENTRADA Y DE SALIDA 
        // P0SO = 0000- 8 BITS QUE NO IMPORTAN
        // P1S1 = 0101- 8 BITS QUE NO IMPORTAN
        // P2S2 = 1010- 8 BITS QUE NO IMPORTAN
        // P3S3 = 1111- 8 BITS QUE NO IMPORTAN

        // Para Almost_full para los fifos de entrada
        
        // PALABRA 2
        // Se mantiene Almost_full en S3
        @(posedge clk);
        probador_pop <= 4'b0000;
        data_in <= 12'b000000000001;
        
        @(posedge clk);
        data_in <= 12'b010100110001;
        
        @(posedge clk);
        data_in <= 12'b101000110001;
        
        @(posedge clk);
        data_in <= 12'b111100000001;
            
        // PALABRA 3
        @(posedge clk);
        data_in <= 12'b000000000101;

        @(posedge clk);
        data_in <= 12'b010100110111;

        @(posedge clk);
        data_in <= 12'b101010110001;

        @(posedge clk);
        data_in <= 12'b111101010111;

        // PALABRA 4
        @(posedge clk);
        data_in <= 12'b000010101101;

        @(posedge clk);
        data_in <= 12'b010100111001;

        @(posedge clk);
        data_in <= 12'b101000111111;

        @(posedge clk);
        data_in <= 12'b111100100111;
     
        // PALABRA 5
        @(posedge clk);
        data_in <= 12'b000010101101;

        @(posedge clk);
        data_in <= 12'b010100111101;

        @(posedge clk);
        data_in <= 12'b101000110111;

        @(posedge clk);
        data_in <= 12'b111101100111;

        // PALABRA 6
        @(posedge clk);
        data_in <= 12'b000000101101;
        
        @(posedge clk);
        data_in <= 12'b010100110101;

        @(posedge clk);
        data_in <= 12'b101011110101;

        // Se hace pop a S3
        @(posedge clk);
        data_in <= 12'b111100001101;
        probador_pop <= 4'b1000;

        // PALABRA 7
        // Se hace pop a P1
        @(posedge clk);
        data_in <= 12'b000011000101;
        probador_pop <= 4'b0001;

        @(posedge clk);
        data_in <= 12'b010100111101;
        probador_pop <= 4'b0001;

        @(posedge clk);
        data_in <= 12'b101000110111;
        probador_pop <= 4'b0001;

        @(posedge clk);
        data_in <= 12'b111100001101;
        probador_pop <= 4'b0001;

        // YA ESTÁN LLENOS LOS FIFO DE ENTRADA 
        // AHORA SE HACE POP PARA QUE SE PUEDA HACER UN ALMOST FULL EN TODOS
        
        @(posedge clk);
        probador_push <= 0;
        probador_pop <= 4'b0010;

        @(posedge clk);
        probador_pop <= 4'b0010;

        @(posedge clk);
        probador_pop <= 4'b0010;
        
        @(posedge clk);
        probador_pop <= 4'b0100;

        @(posedge clk);
        probador_pop <= 4'b1000;

        @(posedge clk);
        probador_pop <= 4'b0001;

        @(posedge clk);
        probador_pop <= 4'b1111;

        @(posedge clk);
        probador_pop <= 4'b1111;

        @(posedge clk);
        probador_pop <= 4'b1111;

        @(posedge clk);
        probador_pop <= 4'b1111;

        @(posedge clk);
        probador_pop <= 4'b1111;

        @(posedge clk);
        probador_pop <= 4'b1111;

        @(posedge clk);
        probador_pop <= 4'b0111;

        @(posedge clk);
        probador_pop <= 4'b0011;

        @(posedge clk);
        probador_pop <= 4'b0010;

        @(posedge clk);
        probador_pop <= 4'b0110;

        @(posedge clk);
        probador_pop <= 4'b0100;

        @(posedge clk);
        probador_pop <= 4'b1000;

        @(posedge clk);
        probador_pop <= 4'b0000;

        @(posedge clk);
        probador_pop <= 4'b0100;

        @(posedge clk);
        probador_pop <= 4'b0100;

        @(posedge clk);
        probador_pop <= 4'b1000;

        @(posedge clk);
        probador_pop <= 4'b0100;

        @(posedge clk);
        probador_pop <= 4'b1000;

        @(posedge clk);
        probador_pop <= 4'b1000;

        @(posedge clk);
        probador_pop <= 4'b1000;

        @(posedge clk);
        probador_pop <= 4'b1000;

        @(posedge clk);
        probador_pop <= 0;

        // Se levanta req para pedir el conteo de cada contador
        // contador 0
        @(posedge clk);
        req <= 1;

        // contador 1
        @(posedge clk);
        idx <= 2'b01;

        // contador 2
        @(posedge clk);
        idx <= 2'b10;

        // contador 3
        @(posedge clk);
        idx <= 2'b11;

        // Se baja req
        @(posedge clk);
        idx <= 0;
        req <= 0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);


        // PRUEBA 2: 16 palabras, 4 a cada FIFO de entrada. 
        // Cada set de 4 palabras por FIFO de entrada van hacia cada FIFO de salida. Dejar todos los fifos vacios.

        @(posedge clk);
        reset <= 0;
        init <= 0;
        full_threshold <= 3'b111;
        empty_threshold <= 3'b000;
        probador_pop <= 0;
        probador_push <= 0;
        data_in <= 0;
        idx <= 0;
        req <= 0;

        // Desactivar el reset
        @(posedge clk);
        reset <= 1; 
	
        // Designar thresholds
        @(posedge clk);
        init <= 1;
        full_threshold <= 3'b111;
        empty_threshold <= 3'b001;

        // Bajar el init para cambiar de estado
        @(posedge clk);
        init <= 0;
        probador_push <= 1;

        // Fifo entrada P0 fifo salida S0
        data_in <= 12'b000001001001;

        // Fifo entrada P0 fifo salida S1
        @(posedge clk);
        data_in <= 12'b000101101011;

        // Fifo entrada P0 fifo salida S2
        @(posedge clk);
        data_in <= 12'b001001101100;

        // Fifo entrada P0 fifo salida S3
        @(posedge clk);
        data_in <= 12'b001110011010;

        // Fifo entrada P1 fifo salida S0
        @(posedge clk);
        data_in <= 12'b010001101011;

        // Fifo entrada P1 fifo salida S1
        @(posedge clk);
        data_in <= 12'b010101101100;

        // Fifo entrada P1 fifo salida S2
        @(posedge clk);
        data_in <= 12'b011010011010;

        // Fifo entrada P1 fifo salida S3
        @(posedge clk);
        data_in <= 12'b011110011010;
    
        // Fifo entrada P2 fifo salida S0
        @(posedge clk);
        data_in <= 12'b100001101011;

        // Fifo entrada P2 fifo salida S1
        @(posedge clk);
        data_in <= 12'b100101101100;

        // Fifo entrada P2 fifo salida S2
        @(posedge clk);
        data_in <= 12'b101010011010;

        // Fifo entrada P2 fifo salida S3
        @(posedge clk);
        data_in <= 12'b101110011010;

        // Fifo entrada P3 fifo salida S0
        @(posedge clk);
        data_in <= 12'b110001101011;

        // Fifo entrada P3 fifo salida S1
        @(posedge clk);
        data_in <= 12'b110101101100;

        // Fifo entrada P3 fifo salida S2
        @(posedge clk);
        data_in <= 12'b111010011010;

        // Fifo entrada P3 fifo salida S3
        @(posedge clk);
        data_in <= 12'b111110011010;

        // Hacer pop
        @(posedge clk);
        probador_push <= 0;
        data_in <= 0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        probador_pop <= 4'b1111;
        
        @(posedge clk);
        probador_pop <= 4'b1111;

        @(posedge clk);
        probador_pop <= 4'b1111;

        @(posedge clk);
        probador_pop <= 4'b1111;

        @(posedge clk);
        probador_pop <= 0;
        
        // Pedir contadores
        @(posedge clk);
        req <= 1;

        @(posedge clk);
        idx <= 2'b01;

        @(posedge clk);
        idx <= 2'b10;

        @(posedge clk);
        idx <= 2'b11;

        @(posedge clk);
        idx <= 0;
        req <= 0;
        
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
		$finish;

	end
endmodule