
module encryptRound(in,sbox_seed, round_num,key,out);
input [127:0] in;
input [255:0] sbox_seed;
input [31:0] round_num;
output [127:0] out;
input [127:0] key;

wire [127:0] SBRO; //Shift Row Output
wire [127:0] SBO; //Sub Bytes Output
wire [127:0] SBCO;


subBytes s(in,SBO,sbox_seed,round_num);
shiftRows r(SBO,SBRO);
mixcolumns cols(SBRO,SBCO);
addRoundKey b(SBCO,out,key);

		
endmodule