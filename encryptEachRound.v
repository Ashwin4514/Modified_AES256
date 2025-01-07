module encryptRound(in,sbox_seed, round_num,key,out);
input [127:0] in;
input [255:0] sbox_seed;
input [31:0] round_num;
output [127:0] out;
input [127:0] key;

wire [127:0] SBRO; //Shift Row Output
wire [127:0] SBO; //Sub Bytes Output


subBytes s(in,SBO,sbox_seed,round_num);
shiftRows r(SBO,SBRO);
addRoundKey b(SBRO,out,key);
		
endmodule