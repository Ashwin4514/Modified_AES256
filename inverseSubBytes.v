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
  input [127:0] threshold
);

genvar i;
generate 
for(i=0;i<128;i=i+8) begin :sub_Bytes 
	invSbox s(in[i +:8],out[i +:8]);
	end
endgenerate

endmodule
