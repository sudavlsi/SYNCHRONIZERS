// Code your design here
module flop_synchronizer#(parameter NUM_STAGES = 2 , BIT_WIDTH = 1)(input logic  clkB , rstN ,input logic  [BIT_WIDTH - 1 : 0] dinA , output logic  [BIT_WIDTH - 1 : 0] doutB );
  
  (* ASYNC_REG = "TRUE" *)logic [BIT_WIDTH - 1 : 0] sync_flop [0 : NUM_STAGES - 1];
	 
  assign doutB = sync_flop[NUM_STAGES - 1];
     
  always@(posedge clkB or negedge rstN) begin
    if(!rstN) begin
      sync_flop <= '{default:{BIT_WIDTH{1'b0}}};
    end
    else begin

      	sync_flop[0]     <= dinA;

      for(int i=0; i < NUM_STAGES - 1 ; i++ )begin
        sync_flop[i+1] <= sync_flop[i];
      end
    end
  end
  
  
endmodule
