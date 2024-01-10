module sbox(
       input [7:0] a,
       output reg [7:0] c,
       output reg [7:0] threshold);

   always @(a) begin
    
    threshold = $urandom % 256;
    c = a^threshold;
end
endmodule