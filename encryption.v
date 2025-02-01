`include "sbox.v"
`include "SubBytes.v"
`include "shiftRows.v"
`include "mixcolumns.v"
`include "encryptEachRound.v"


module encryption #(parameter N=256,parameter Numkeys=8,parameter NumRounds=14)
  (input clk,
   input rst,
   input wire  [127:0] in,
   input wire  [N-1:0] key,
   input wire  [N-1:0] sbox_seed,
   output wire  [127:0] out);
  
  reg[127:0] out_reg;


wire [(128*(NumRounds+1))-1 :0] expandedkeys;
wire [127:0] shiftRowsOut;
wire [127:0] subBytesOut;
wire [127:0] stages[NumRounds+1:0] ;

keyExpansion #(Numkeys,NumRounds) ke (key,expandedkeys);

addRoundKey addrk1 (in,stages[0],expandedkeys[((128*(NumRounds+1))-1)-:128]);

genvar i;
generate
	for(i=1; i<NumRounds ;i=i+1)begin : loop
		encryptRound er(stages[i-1], 
		                sbox_seed,
		                i,
		                expandedkeys[(((128*(NumRounds+1))-1)-128*i)-:128],
		                stages[i]);
	end
	endgenerate
    subBytes sb(stages[NumRounds-1],subBytesOut, sbox_seed, NumRounds);
    shiftRows sr(subBytesOut,shiftRowsOut);
    addRoundKey addrk2(shiftRowsOut,stages[NumRounds],expandedkeys[127:0]);
    
    generate 
    for(i=1; i<NumRounds ;i=i+1) begin
        initial begin
         #10;
         $display("Encrypted data: %h",stages[i]);
        end
    end
    endgenerate 
  
  always@(posedge clk) begin
    if(rst) out_reg <= 0;
    else out_reg <= stages[NumRounds];
  end
  
  assign out = out_reg;
    
endmodule
