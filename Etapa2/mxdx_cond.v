
module mxdx_cond #(
    parameter FIFO_UNITS = 4,   // Cantidad de FIFOs
    parameter WORD_SIZE = 10,   // Cantidad de bits
    parameter PTR_L = 3         //Longitud de bits para el puntero
    )(  // entradas
        input wire [FIFO_UNITS-1:0] arb_pop,
        input wire [FIFO_UNITS-1:0] arb_push,
        input wire  [WORD_SIZE-1:0] fifo_data_in0,
        input wire  [WORD_SIZE-1:0] fifo_data_in1,
        input wire  [WORD_SIZE-1:0] fifo_data_in2,
        input wire  [WORD_SIZE-1:0] fifo_data_in3,
        output wire [WORD_SIZE-1:0] fifo_data_out_cond0,
        output wire [WORD_SIZE-1:0] fifo_data_out_cond1,
        output wire [WORD_SIZE-1:0] fifo_data_out_cond2,
        output wire [WORD_SIZE-1:0] fifo_data_out_cond3,
        output wire [WORD_SIZE-1:0] data_aux_cond
    );
    // señales intermedias
    reg [WORD_SIZE-1:0] dataIn_aux0, dataIn_aux1, dataIn_aux2, dataIn_aux3;
    reg [WORD_SIZE-1:0] dataOut_aux0, dataOut_aux1, dataOut_aux2, dataOut_aux3;

always @(*) begin
        // Logica de demux
        dataOut_aux0 = fifo_data_out_cond0;
        dataOut_aux1 = fifo_data_out_cond1;
        dataOut_aux2 = fifo_data_out_cond2;
        dataOut_aux3 = fifo_data_out_cond3;

         //Logica de mux
        dataIn_aux0 = fifo_data_in0;
        dataIn_aux1 = fifo_data_in1;
        dataIn_aux2 = fifo_data_in2;
        dataIn_aux3 = fifo_data_in3;
        
        // Logica de demux
        if(fifo_data_in[9:8]== 2'b00) begin
            fifo_data_out_cond0 = fifo_data_in;  
            fifo_data_out_cond1 = 0;
            fifo_data_out_cond2 = 0;
            fifo_data_out_cond3 = 0;      
        end

        else if(fifo_data_in[9:8]== 2'b01) begin
            fifo_data_out_cond0 = 0;    
            fifo_data_out_cond1 = fifo_data_in;
            fifo_data_out_cond2 = 0;
            fifo_data_out_cond3 = 0;          
        end

        else if(fifo_data_in[9:8]== 2'b10) begin
            fifo_data_out_cond0 = 0;    
            fifo_data_out_cond1 = 0;    
            fifo_data_out_cond2 = fifo_data_in;  
            fifo_data_out_cond3 = 0;    
        end

        else begin
            fifo_data_out_cond0 = 0; 
            fifo_data_out_cond1 = 0; 
            fifo_data_out_cond2 = 0;          
            fifo_data_out_cond3 = fifo_data_in;  
        end

        //Logica de mux
        if(arb_pop == 4'b0001) begin
            fifo_data_out_cond = fifo_data_in0;  
        end

        else if(arb_pop == 4'b0010) begin
            fifo_data_out_cond = fifo_data_in1;  
        end

        else if(arb_pop == 4'b0100) begin
            fifo_data_out_cond = fifo_data_in2;  
        end

        else if(arb_pop == 4'b1000) begin
            fifo_data_out_cond = fifo_data_in3;  
        end

        else fifo_data_out_cond = 0;
        
       
    end 


endmodule