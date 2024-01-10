module encrpytor_tb;

reg [127:0] in;
wire [127:0] out;
reg [255:0] key;
wire [128*(14)-1:0] temp;

encryption c(in,key,out,temp);

initial begin
$monitor("in= %h, key= %h ,out= %h, temp= %h ",in,key,out,temp);
in=128'habcdefadcdef01234567890123456789;
key=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
#10;
end

endmodule