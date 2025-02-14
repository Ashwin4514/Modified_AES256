`include "invSbox.v"
`include "inverseSubBytes.v"
`include "invShiftRows.v"
`include "invMixColumns.v"
`include "decryptEachRound.v"

module decryption 
  #(parameter N=256,parameter NumRounds=14,parameter Numkeys=8)(
    input clk,
    input rst,
    input  wire [127:0] in,
    input  wire [N-1:0] key,
    output wire [127:0] out,
	input  wire [N-1:0] sbox_seed
  );
  
  reg [127:0] out_reg;

wire [(128*(NumRounds+1))-1 :0] expandedkeys;
wire [127:0] ShiftRowsOut;
wire [127:0] stages [NumRounds+1:0] ;
wire [127:0] SubBytesOut;
wire [127:0] MixColsOut;

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
	
	inverseMixColumns invmixcols(stages[NumRounds-1], MixColsOut);
    inverseShiftRows sr(MixColsOut,ShiftRowsOut);
    inverseSubBytes sb(ShiftRowsOut,SubBytesOut,sbox_seed,1);
    addRoundKey addrk2(SubBytesOut,stages[NumRounds],expandedkeys[((128*(NumRounds+1))-1)-:128]);
  
  always@(posedge clk) begin
    if(rst) out_reg <= 0;
    else out_reg <= stages[NumRounds];
  end
        
assign out=out_reg;

endmodule