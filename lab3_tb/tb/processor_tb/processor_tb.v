`timescale 1ns/1ps

module processor_tb();

   reg clock;
   reg reset;

   wire [7:0] serial_out;
   wire serial_wren;

   // Generate clock at 10 MHz
   initial begin
   	clock <= 1'b0;
   	reset <= 1'b1;
   	forever #1 clock <= ~clock;
   end

   // Drop reset after 5 ns
   always begin
   	#5 reset <= 1'b0;
   end
   	
   	
   // instantiate the processor  "DUT"
   processor dut(
   	.clock(clock),
   	.reset(reset),
   	.serial_in(8'b0),
   	.serial_valid_in(1'b0),   // active-high - we never have anything to read from the serial port
   	.serial_ready_in(1'b1),   // active-high - we are always ready to print serial data
   	.serial_rden_out(),       // active-high
   	.serial_out(serial_out),
   	.serial_wren_out(serial_wren) //active-high
   );


   initial begin

      wait(dut.rf.rf[25] == 1);

      if(dut.rf.rf[2] != 32'h0000_0001)
         $display("addi:\t\tfailed");
      else
         $display("addi:\t\tpassed");

      if(dut.rf.rf[3] != 32'h0000_0002)
         $display("add:\t\tfailed");
      else
         $display("add:\t\tpassed");

      if(dut.rf.rf[4] != 32'hFFFF_FFFF)
         $display("sub:\t\tfailed");
      else
         $display("sub:\t\tpassed");

      if(dut.rf.rf[5] != 32'h0000_00F0)
         $display("and:\t\tfailed");
      else
         $display("and:\t\tpassed");

      if(dut.rf.rf[6] != 32'h0000_00FF)
         $display("or:\t\tfailed");
      else
         $display("or:\t\tpassed");

      if(dut.rf.rf[7] != 32'h0000_0FF0)
         $display("xor:\t\tfailed");
      else
         $display("xor:\t\tpassed");

      if(dut.rf.rf[8] != 32'hFFFF_F000)
         $display("nor:\t\tfailed");
      else
         $display("nor:\t\tpassed");

      if(dut.rf.rf[9] != 32'h0000_00FF)
         $display("sw or lw:\tfailed");
      else
         $display("sw or lw:\tpassed");

      $stop;

   end

endmodule