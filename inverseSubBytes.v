`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2024 08:30:43 PM
// Design Name: 
// Module Name: inverseSubBytes
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module inverseSubBytes(
  input [127:0] in,
  output [127:0] out,
  input [255:0] sbox_seed,
  input [31:0] round_num 
);

invSbox s(in,out,sbox_seed, round_num);

 initial begin
 #1
  $display("In Decryption, Round Number: %d, Generated Output: %h", round_num, out);
 end
endmodule
