// Code your design here
`include "keyExpansion.v"
`include "addRoundKey.v"
`include "chacha20_prng.v"
`include "encryption.v"
`include "decryption.v"

module DUTWrapper(
  	input clk,
  	input rst,
    input [255:0] key,
    input [127:0] data_in,
    output[127:0] data_out_enc,
    output[127:0] data_out_dec,
  	input [255:0] sbox_seed
);
   
    encryption encryptor(
    .clk(clk),
    .rst(rst),
    .in(data_in),
    .sbox_seed(sbox_seed),
    .key(key),
      .out(data_out_enc)
    );
    
    decryption decryptor(
    .clk(clk),
    .rst(rst), 
    .in(data_out_enc),
    .sbox_seed(sbox_seed),
    .key(key),
    .out(data_out_dec)
    );

endmodule