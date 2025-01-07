module decryptRound(in,key,out,sbox_seed,round_num);
input [127:0] in;
output [127:0] out;
input [127:0] key;
input [255:0] sbox_seed;
input [31:0] round_num;
wire [127:0] SBO;
wire [127:0] SBRO;

inverseShiftRows r(in,SBRO);
inverseSubBytes s(SBRO,SBO,sbox_seed,round_num);
addRoundKey b(SBO,out,key);

endmodule