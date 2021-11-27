`include "fifo.v"
`include "maquina_estado.v"
`include "arbitro1.v"
`include "arbitro2.v"
`include "contador.v"

module transaction #(
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
    // inputs
    input clk,
    input reset,
    input init,
    input [PTR-1:0] full_threshold,
    input [PTR-1:0] empty_threshold,
    input probador_push,
    input [WORD_SIZE-1:0] data_in,
    input [3:0] probador_pop,
    input [1:0] idx, 
    input req,
    
    // outputs
    output [WORD_SIZE-1:0] data_out_S0,
    output [WORD_SIZE-1:0] data_out_S1,
    output [WORD_SIZE-1:0] data_out_S2,
    output [WORD_SIZE-1:0] data_out_S3,
    output valid,
    output [4:0] cuenta,
    output [6:0] contador_4,
    output [1:0] state
    );
    
    // cables auxiliares:

    // Para los fifos 
    wire [PTR-1:0] fifos_full_threshold;
    wire [PTR-1:0] fifos_empty_threshold;

    wire error_initial;
    wire almost_full_initial;
    wire fifo_full_initial;

    wire error_P0;
    wire fifo_full_P0;

    wire error_P1;
    wire fifo_full_P1;
    
    wire error_P2;
    wire fifo_full_P2;

    wire error_P3;
    wire fifo_full_P3;
    
    wire error_S0;
    wire almost_empty_S0;
    wire fifo_full_S0;
    
    wire error_S1;
    wire almost_empty_S1;
    wire fifo_full_S1;

    wire error_S2;
    wire almost_empty_S2;
    wire fifo_full_S2;
    
    wire error_S3;
    wire almost_empty_S3;
    wire fifo_full_S3;
    
    // para los árbitros
    wire fifo_empty;
    wire fifo_almost_empty;
    wire [3:0] fifos_almost_empty;
    wire [3:0] fifos_empty;
    wire [3:0] fifos_almost_full_S;
    wire [3:0] fifos_empty_S;

    wire [WORD_SIZE-1:0] fifo_data_out_cond;

    wire [3:0] fifos_almost_full;
    
    wire [WORD_SIZE-1:0] fifo_data_out;
    wire [WORD_SIZE-1:0] data_out_arb;
    
    wire [WORD_SIZE-1:0] fifo_data_in0;
    wire [WORD_SIZE-1:0] fifo_data_in1;
    wire [WORD_SIZE-1:0] fifo_data_in2;
    wire [WORD_SIZE-1:0] fifo_data_in3;
    wire pop;
    wire [3:0] push;
    wire [3:0] fifos_pop;
    wire [3:0] fifos_push;
    
    // para el contador 
    wire idle;
    
    
    // para la máquina de estados 
    reg [8:0] empty;
    
    // Primera etapa: fifo inicial
    fifo    #(  .MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR))  fifo_initial (
                                        // inputs
                                        .clk                (clk),
                                        .reset              (reset),
                                        .fifo_wr            (probador_push),            // Viene del probador             
                                        .fifo_rd            (pop),                      // Viene del Árbitro 2
                                        .full_threshold     (fifos_full_threshold),     // Viene de la maquina de estado 
                                        .empty_threshold    (fifos_empty_threshold),    // Viene de la maquina de estado
                                        .fifo_data_in       (data_in),                  // Viene del probador
                                        
                                        // outputs
                                        .error              (error_initial),            // Anda suelto
                                        .almost_empty       (fifo_almost_empty),        // Va al Árbitro 2
                                        .almost_full        (almost_full_initial),
                                        .fifo_full          (fifo_full_initial),                
                                        .fifo_empty         (fifo_empty),               // Va al Árbitro 2
                                        .fifo_data_out      (fifo_data_out)             // Va al Árbitro 2
                                    );
    
    // Segunda etapa: Arbitro 2
    arbitro2 #( .WORD_SIZE(WORD_SIZE)) 
                            arbitro_2 (
                                        // inputs
                                        .clk                (clk),  
                                        .reset              (reset),
                                        .data_in_arb        (fifo_data_out),            // Viene del fifo inicial
                                        .fifo_empty         (fifo_empty),               // Viene del fifo inicial
                                        .fifos_almost_full  (fifos_almost_full),        // Viene de los fifos de entrada

                                        // outputs
                                        .data_out_arb       (data_out_arb),             // Va a los fifos de entrada
                                        .pop                (pop),                      // Va al fifo inicial
                                        .push               (push)                      // Va a los fifos de entrada
                                    );

    // Tercera etapa: fifos entrada
    fifo    #(  .MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR))  fifo_P0 (
                                        // inputs
                                        .clk                (clk),
                                        .reset              (reset),
                                        .fifo_wr            (push[0]),                  // Viene del Árbitro 2            
                                        .fifo_rd            (fifos_pop[0]),             // Viene del Árbitro 1
                                        .full_threshold     (fifos_full_threshold),     // Viene de la maquina de estado 
                                        .empty_threshold    (fifos_empty_threshold),    // Viene de la maquina de estado
                                        .fifo_data_in       (data_out_arb),             // Viene del Arbitro 2
                                        
                                        // outputs
                                        .error              (error_P0),                 // Anda suelto
                                        .almost_empty       (fifos_almost_empty[0]),    // Va al Árbitro 1        
                                        .almost_full        (fifos_almost_full[0]),     // Va al Árbitro 2
                                        .fifo_full          (fifo_full_P0),                
                                        .fifo_empty         (fifos_empty[0]),           // Va al Árbitro 1
                                        .fifo_data_out      (fifo_data_in0)             // Va al Árbitro 1
                                    );
    
    fifo    #(  .MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR))  fifo_P1 (
                                        // inputs
                                        .clk                (clk),
                                        .reset              (reset),
                                        .fifo_wr            (push[1]),                  // Viene del Árbitro 2            
                                        .fifo_rd            (fifos_pop[1]),             // Viene del Árbitro 1
                                        .full_threshold     (fifos_full_threshold),     // Viene de la maquina de estado 
                                        .empty_threshold    (fifos_empty_threshold),    // Viene de la maquina de estado
                                        .fifo_data_in       (data_out_arb),             // Viene del Arbitro 2
                                        
                                        // outputs
                                        .error              (error_P1),                 // Anda suelto
                                        .almost_empty       (fifos_almost_empty[1]),    // Va al Árbitro 1    
                                        .almost_full        (fifos_almost_full[1]),     // Va al Árbitro 2
                                        .fifo_full          (fifo_full_P1),                
                                        .fifo_empty         (fifos_empty[1]),           // Va al Árbitro 1
                                        .fifo_data_out      (fifo_data_in1)             // Va al Árbitro 1
                                    );
    
    fifo    #(  .MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR))  fifo_P2 (
                                        // inputs
                                        .clk                (clk),
                                        .reset              (reset),
                                        .fifo_wr            (push[2]),                  // Viene del Árbitro 2            
                                        .fifo_rd            (fifos_pop[2]),             // Viene del Árbitro 1
                                        .full_threshold     (fifos_full_threshold),     // Viene de la maquina de estado 
                                        .empty_threshold    (fifos_empty_threshold),    // Viene de la maquina de estado
                                        .fifo_data_in       (data_out_arb),             // Viene del Arbitro 2
                                        
                                        // outputs
                                        .error              (error_P0),                 // Anda suelto
                                        .almost_empty       (fifos_almost_empty[2]),    // Va al Árbitro 1        
                                        .almost_full        (fifos_almost_full[2]),     // Va al Árbitro 2
                                        .fifo_full          (fifo_full_P2),                
                                        .fifo_empty         (fifos_empty[2]),           // Va al Árbitro 1
                                        .fifo_data_out      (fifo_data_in2)             // Va al Árbitro 1
                                    );
    
    fifo    #(  .MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR))  fifo_P3 (
                                        // inputs
                                        .clk                (clk),
                                        .reset              (reset),
                                        .fifo_wr            (push[3]),                  // Viene del Árbitro 2            
                                        .fifo_rd            (fifos_pop[3]),             // Viene del Árbitro 1
                                        .full_threshold     (fifos_full_threshold),     // Viene de la maquina de estado 
                                        .empty_threshold    (fifos_empty_threshold),    // Viene de la maquina de estado
                                        .fifo_data_in       (data_out_arb),             // Viene del Arbitro 2
                                        
                                        // outputs
                                        .error              (error_P3),                 // Anda suelto
                                        .almost_empty       (fifos_almost_empty[3]),    // Va al Árbitro 1         
                                        .almost_full        (fifos_almost_full[3]),     // Va al Árbitro 2
                                        .fifo_full          (fifo_full_P3),                
                                        .fifo_empty         (fifos_empty[3]),           // Va al Árbitro 1
                                        .fifo_data_out      (fifo_data_in3)             // Va al Árbitro 1
                                    );

    // Cuarta etapa: Arbitro 1
    arbitro1    #(  .WORD_SIZE(WORD_SIZE)) 
                            arbitro_1 (
                                        // inputs
                                        .clk                (clk),  
                                        .reset              (reset),
                                        .fifo_data_in0      (fifo_data_in0),            // Viene de fifo_P0
                                        .fifo_data_in1      (fifo_data_in1),            // Viene de fifo_P1
                                        .fifo_data_in2      (fifo_data_in2),            // Viene de fifo_P2
                                        .fifo_data_in3      (fifo_data_in3),            // Viene de fifo_P3
                                        .fifos_almost_full  (fifos_almost_full_S),      // Viene de los fifos de salida
                                        .fifos_empty        (fifos_empty),              // Viene de los fifos de entrada

                                        // outputs
                                        .fifo_data_out_cond (fifo_data_out_cond),       // Va a los fifos de salida
                                        .fifos_pop          (fifos_pop),                // Va a los fifos de entrada
                                        .fifos_push         (fifos_push)                // Va a los fifos de salida
                                        
                                    );
    // Quinta etapa: fifos salida
                              
    fifo    #(  .MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR))  fifo_S0 (
                                        // inputs
                                        .clk                (clk),
                                        .reset              (reset),
                                        .fifo_wr            (fifos_push[0]),            // Viene del Árbitro 1            
                                        .fifo_rd            (probador_pop[0]),          // Viene del probador
                                        .full_threshold     (fifos_full_threshold),     // Viene de la maquina de estado 
                                        .empty_threshold    (fifos_empty_threshold),    // Viene de la maquina de estado
                                        .fifo_data_in       (fifo_data_out_cond),       // Viene del Arbitro 1
                                        
                                        // outputs
                                        .error              (error_S0),                 // Anda suelto
                                        .almost_empty       (almost_empty_S0),          // Anda suelto
                                        .almost_full        (fifos_almost_full_S[0]),   // Va al Árbitro 1
                                        .fifo_full          (fifo_full_S0),             // Anda suelto
                                        .fifo_empty         (fifos_empty_S[0]),         // Va a la maquina
                                        .fifo_data_out      (data_out_S0)               // Va al contador
   
                                    );

 
    fifo    #(  .MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR))  fifo_S1 (
                                        // inputs
                                        .clk                (clk),
                                        .reset              (reset),
                                        .fifo_wr            (fifos_push[1]),            // Viene del Árbitro 1            
                                        .fifo_rd            (probador_pop[1]),          // Viene del probador
                                        .full_threshold     (fifos_full_threshold),     // Viene de la maquina de estado 
                                        .empty_threshold    (fifos_empty_threshold),    // Viene de la maquina de estado
                                        .fifo_data_in       (fifo_data_out_cond),       // Viene del Arbitro 1
                                        
                                        // outputs
                                        .error              (error_S1),                 // Anda suelto
                                        .almost_empty       (almost_empty_S1),          // Anda suelto
                                        .almost_full        (fifos_almost_full_S[1]),   // Va al Árbitro 1
                                        .fifo_full          (fifo_full_S1),             // Anda suelto
                                        .fifo_empty         (fifos_empty_S[1]),         // Va a la maquina
                                        .fifo_data_out      (data_out_S1)               // Va al contador
   
                                    );


    fifo    #(  .MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR))  fifo_S2 (
                                        // inputs
                                        .clk                (clk),
                                        .reset              (reset),
                                        .fifo_wr            (fifos_push[2]),            // Viene del Árbitro 1            
                                        .fifo_rd            (probador_pop[2]),          // Viene del probador
                                        .full_threshold     (fifos_full_threshold),     // Viene de la maquina de estado 
                                        .empty_threshold    (fifos_empty_threshold),    // Viene de la maquina de estado
                                        .fifo_data_in       (fifo_data_out_cond),       // Viene del Arbitro 1
                                        
                                        // outputs
                                        .error              (error_S2),                 // Anda suelto
                                        .almost_empty       (almost_empty_S2),          // Anda suelto
                                        .almost_full        (fifos_almost_full_S[2]),   // Va al Árbitro 1
                                        .fifo_full          (fifo_full_S2),             // Anda suelto
                                        .fifo_empty         (fifos_empty_S[2]),         // Va a la maquina
                                        .fifo_data_out      (data_out_S2)               // Va al contador
                                    );


    fifo    #(  .MEM_SIZE(MEM_SIZE), 
                .WORD_SIZE(WORD_SIZE), 
                .PTR(PTR))  fifo_S3 (
                                        // inputs
                                        .clk                (clk),
                                        .reset              (reset),
                                        .fifo_wr            (fifos_push[3]),            // Viene del Árbitro 1            
                                        .fifo_rd            (probador_pop[3]),          // Viene del probador
                                        .full_threshold     (fifos_full_threshold),     // Viene de la maquina de estado 
                                        .empty_threshold    (fifos_empty_threshold),    // Viene de la maquina de estado
                                        .fifo_data_in       (fifo_data_out_cond),       // Viene del Arbitro 1
                                        
                                        // outputs
                                        .error              (error_S3),                 // Anda suelto
                                        .almost_empty       (almost_empty_S3),          // Anda suelto
                                        .almost_full        (fifos_almost_full_S[3]),   // Va al Árbitro 1
                                        .fifo_full          (fifo_full_S3),             // Anda suelto
                                        .fifo_empty         (fifos_empty_S[3]),         // Va a la maquina
                                        .fifo_data_out      (data_out_S3)               // Va al contador
   
                                    );

   // Sexta etapa: contador
    contador #(  .INDEX(INDEX)) 
                            contador_1 (
                                        // inputs
                                        .clk                (clk),  
                                        .reset              (reset),
                                        .req                (req),
                                        .idx                (idx),
                                        .IDLE               (idle),                      // Viene de la máquina de estados
                                        .pop                (pop),                       // Viene del fifo inicial
                                        .pop_0              (probador_pop[0]),           // Viene del fifo de salida s0
                                        .pop_1              (probador_pop[1]),           // Viene del fifo de salida s1
                                        .pop_2              (probador_pop[2]),           // Viene del fifo de salida s2
                                        .pop_3              (probador_pop[3]),           // Viene del fifo de salida s3
                                        
                                        // outputs
                                        .cuenta             (cuenta),                           
                                        .contador_4         (contador_4),
                                        .valid              (valid)
                                    ); 
                                        
    // Setima etapa: maquina estados 

    maquina_estado #( .PTR(PTR)) 
                            maquina_estado1 (
                                        // inputs
                                        .clk                     (clk),  
                                        .reset                   (reset),
                                        .init                    (init),
                                        .full_threshold          (full_threshold),
                                        .empty_threshold         (empty_threshold),
                                        .fifos_empty             (empty),

                                        // outputs
                                        .fifos_full_threshold    (fifos_full_threshold),
                                        .fifos_empty_threshold   (fifos_empty_threshold),
                                        .idle                    (idle),
                                        .state                   (state)     
                                    );

    always @(*) begin
        empty = {fifos_empty_S, fifos_empty, fifo_empty};
    end
endmodule