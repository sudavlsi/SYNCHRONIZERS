`timescale 1ns/1ps

module flop_synchronizer_tb;

   // Parameters
   parameter NUM_STAGES = 2;
   parameter BIT_WIDTH = 4;

   // Testbench signals
   logic clkB;
   logic rstN;
   logic [BIT_WIDTH-1:0] dinA;
   logic [BIT_WIDTH-1:0] doutB;

   // DUT instantiation
   flop_synchronizer #(
      .NUM_STAGES(NUM_STAGES),
      .BIT_WIDTH(BIT_WIDTH)
   ) dut (
      .clkB(clkB),
      .rstN(rstN),
      .dinA(dinA),
      .doutB(doutB)
   );

   // Clock generation
   initial begin
      clkB = 0;
      forever #5 clkB = ~clkB; // 10ns clock period
   end

   // Test sequence
   initial begin
      // Initialize inputs
      rstN = 0;
      dinA = 0;

      // Apply reset
      #10;
      rstN = 1;

      // Apply test stimulus
      #10 dinA = 4'b1010;
      #20 dinA = 4'b1100;
      #20 dinA = 4'b1111;

      // Wait and finish
      #50;
      $finish;
   end

   // Monitor outputs
   initial begin
      $monitor("Time: %0t | rstN: %b | dinA: %b | doutB: %b", $time, rstN, dinA, doutB);
   end
   
   initial begin
    if($test$plusargs("DUMP_VCD")) begin
        $dumpfile("run_last/wave.vcd");
        $dumpvars;
    end
 end
endmodule
