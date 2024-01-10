module decryption #(parameter N=256,parameter NumRounds=14,parameter Numkeys=8)(in,key,out,threshold);
input [127:0] in;
input [N-1:0] key;
output [127:0] out;
input [128*(NumRounds)-1 :0] threshold;


wire [(128*(NumRounds+1))-1 :0] expandedkeys;
wire [127:0] ShiftRowsOut;
wire [127:0] stages [NumRounds+1:0] ;
wire [127:0] SubBytesOut;


keyExpansion #(Numkeys,NumRounds) ke (key,expandedkeys);

addRoundKey addrk1 (in,stages[0],expandedkeys[127:0]);

genvar i;
generate
	
	for(i=1; i<NumRounds ;i=i+1)begin
		decryptRound dr(
		stages[i-1],
		expandedkeys[i*128+:128],
		stages[i],
		threshold[(i-1)*128+:128]);
		
		end
		inverseShiftRows sr(stages[NumRounds-1],ShiftRowsOut);
		inverseSubBytes sb(ShiftRowsOut,SubBytesOut,threshold[((128*NumRounds)-1)-:128]);
		addRoundKey addrk2(SubBytesOut,stages[NumRounds],expandedkeys[((128*(NumRounds+1))-1)-:128]);
		
	assign out=stages[NumRounds];

endgenerate
endmodule