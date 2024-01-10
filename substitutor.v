module substitutor(inByte,outByte,threshold);
input [127:0] inByte;
output [127:0] outByte;
output [127:0] threshold;

genvar i;
generate 
for(i=0;i<=120;i=i+8) begin 
	sbox s(inByte[i +:8],outByte[i +:8],threshold[i +:8]);
	end
endgenerate


endmodule