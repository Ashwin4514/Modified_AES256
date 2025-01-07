module sbox(
    input [127:0] a,
    output reg [127:0] c,
    input [255:0] sbox_seed,
    input [31:0]round_num
    );
    
    wire [127:0] threshold;
    
    chacha20_prng prng(.seed(sbox_seed),.round_number(round_num),.random(threshold));
    
     initial begin
        #1;
        $display("In Encryption, Round Number: %d, Generated Value: %d", round_num, threshold);
     end
   
  // Output S-box value
  always @* begin
    c = a^threshold;
  end
endmodule
