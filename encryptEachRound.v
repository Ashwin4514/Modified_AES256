module encryptRound(in,key,out,thres);
input [127:0] in;
output [127:0] out;
input [127:0] key;
output [127:0] thres;

wire [127:0] SBRO; //Shift Row Output
wire [127:0] SBO; //Sub Bytes Output


subBytes s(in,SBO,thres);
shiftRows r(SBO,SBRO);
addRoundKey b(SBRO,out,key);
		
endmodule