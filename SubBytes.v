`timescale 1ns / 1ps

module subBytes(in,out,sbox_seed,round_num);
input [127:0] in;
input [255:0] sbox_seed;
input [31:0] round_num;
output [127:0] out;

sbox s(.a(in),.c(out),.sbox_seed(sbox_seed),.round_num(round_num));

 initial begin
 #1;
  $display("In Encryption, Round Number: %d, Generated Output: %h", round_num, out);
 end

endmodule
