module sbox(
    input [7:0] a,
    output reg [7:0] c,
    output reg [7:0] threshold);

  // Linear feedback shift register
  reg [63:0] state = 64'h00000000000000000000000001010111010;
  
  wire count = $urandom % 32;
  initial begin
    repeat (count) begin
    state <= state << 1;
    state[0] <= (state[1] ^ state[2]);
    end
  end

  always @* begin
    threshold = state[7:0];
  end

  // Output S-box value
  always @* begin
    c = a^threshold;
  end
endmodule
