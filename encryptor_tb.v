module encrpytor_tb;

reg [127:0] in;
wire [127:0] out;
reg [255:0] key;
reg [255:0] sbox_seed;


encryption c(in,sbox_seed,key,out);

initial begin
$monitor("in= %h, key= %h ,out= %h ",in,key,out);
in=128'habcdefadcdef01234567890123456789;
key=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
sbox_seed=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
#10;
end

endmodule