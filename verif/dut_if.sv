interface dut_if(input bit clk);
  	logic rst;
    logic [255:0] key;
    logic [127:0] data_in;
    logic [127:0] data_out_enc;
    logic [127:0] data_out_dec;
  	logic [255:0] sbox_seed;
  
  clocking cb_drv @(posedge clk);
    default input #1step output #1;
    output key, data_in, sbox_seed; //Signals driven by the testbench towards
  endclocking
  
  clocking cb_mon @(posedge clk);
    default input #1step output #1;
    input key, data_in, sbox_seed, data_out_enc, data_out_dec;
  endclocking
 
endinterface


