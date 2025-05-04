module reset_synchronizer_tb;

    // Testbench signals
    logic rstN;
    logic clk;
    logic sync_rstN;
 
    // DUT instantiation
    reset_synchronizer uut (
       .rstN(rstN),
       .clk(clk),
       .sync_rstN(sync_rstN)
    );
 
    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz clock
 
    // Test sequence
    initial begin
       // Initialize signals
       rstN = 0;
 
       // Apply reset
       #20 rstN = 1;
       #50 rstN = 0;
       #30 rstN = 1;
 
       // Wait for some time
       #100;
 
       // Finish simulation
       $finish;
    end
 
    // Monitor signals
    initial begin
       $monitor("Time: %0t | rstN: %b | sync_rstN: %b", $time, rstN, sync_rstN);
    end
 
 endmodule