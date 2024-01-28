`timescale 1ns / 1ps

module subBytes(in,out, threshold);
input [127:0] in;
output [127:0] out;
output [127:0] threshold;

genvar i;
generate 
for(i=0;i<128;i=i+8) begin :sub_Bytes 
	sbox s(in[i +:8],out[i +:8],threshold[i +:8]);
	end
endgenerate       
endmodule
