// Code your testbench here
// or browse Examples
`include "aes_sequence_item.sv"
`include "aes_sequence.sv"
`include "aes_env.sv"
`include "aes_test.sv"
`include "dut_if.sv"

module top_tb;
    
 initial begin
	$dumpfile("dump.vcd");
  	$dumpvars(0);
 end
  
reg clk;
 always #1 clk =~ clk; 
  
  dut_if dut_intf(clk);


DUTWrapper uut (
  	.clk(clk),
  	.rst(dut_intf.rst),
  	.key(dut_intf.key),
    .data_in(dut_intf.data_in),
    .data_out_enc(dut_intf.data_out_enc),
    .data_out_dec(dut_intf.data_out_dec),
    .sbox_seed(dut_intf.sbox_seed)
);

aes_test test;
  
  initial begin
    dut_intf.rst = 1;
    #10 dut_intf.rst = 0;
  end
  

initial begin
    //Se    // Alternatively, set verbosity for specific components
  	clk <= 0;
    uvm_top.set_report_verbosity_level(UVM_DEBUG);
    uvm_top.print_topology();
    uvm_config_db#(virtual dut_if)::set(null, "*", "vif", dut_intf);
  `uvm_info("top_tb", $sformatf("Interface Values: clk -  %d, rst - %d", dut_intf.clk, dut_intf.rst), UVM_LOW);
  
  	run_test();
      #5000;  // Allow the test to run for some time
    $finish; // End the simulation
end
                             
endmodule