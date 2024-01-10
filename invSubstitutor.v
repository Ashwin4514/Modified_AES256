module invSubstitutor(
            input [127:0] in,
            output [127:0] out,
            input [127:0] threshold);

genvar i;
generate 
for(i=0;i<=120;i=i+8) begin 
	invSbox s(in[i +:8],out[i +:8],threshold[i +:8]);
	end
endgenerate


endmodule