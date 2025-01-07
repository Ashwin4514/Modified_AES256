module invSbox(
         input  [127:0] in, 
         output reg [127:0] out,
         input  [255:0] sbox_seed,
         input  [31:0] round_num);

wire [127:0] generated_val;

chacha20_prng prng_dec(.seed(sbox_seed), .round_number(round_num), .random(generated_val)); 

 initial begin
 #1;
  $display("In Decryption, Round Number: %d, Generated Value: %d", round_num, generated_val);
  end

 always@(*)
 begin
  out = in ^ generated_val; 
 end
endmodule