module decryption #(parameter N=256,parameter NumRounds=14,parameter Numkeys=8)(in,key,out,sbox_seed);
input [127:0] in;
input [N-1:0] key;
output [127:0] out;
input [N-1:0] sbox_seed;


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
		                sbox_seed,
		                NumRounds-i+1);
		end
		endgenerate
    inverseShiftRows sr(stages[NumRounds-1],ShiftRowsOut);
    inverseSubBytes sb(ShiftRowsOut,SubBytesOut,sbox_seed,1);
    addRoundKey addrk2(SubBytesOut,stages[NumRounds],expandedkeys[((128*(NumRounds+1))-1)-:128]);
    
    generate 

    for(i=1; i<NumRounds ;i=i+1) begin
        initial begin
         #10;
         $display("Decrypted data: %h",stages[i]);
        end
    end
    endgenerate
    
 assign out=stages[NumRounds];

endmodule