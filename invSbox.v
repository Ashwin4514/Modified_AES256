module invSbox(
         input  [7:0] in, 
         output reg [7:0] out,
         input  [7:0] threshold);


 always@(*)
 begin
    out = in ^ threshold; 
 end
endmodule