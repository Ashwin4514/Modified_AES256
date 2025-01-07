`timescale 1ns / 1ps

module inverseMixColumns (
    input  [127:0] in,   // Input state (4x4 bytes)
    output [127:0] out   // Output state after InverseMixColumns
);

    function [7:0] xtime(input [7:0] b);
        // Multiplies b by 2 in GF(2^8)
        xtime = (b << 1) ^ ((b & 8'h80) ? 8'h1b : 8'h00);
    endfunction

    function [7:0] gmul(input [7:0] a, input [7:0] b);
        // Multiplies a by b in GF(2^8)
        reg [7:0] p;
        integer i;
        begin
            p = 0;
            for (i = 0; i < 8; i = i + 1) begin
                if (b[0])
                    p = p ^ a;
                a = xtime(a);
                b = b >> 1;
            end
            gmul = p;
        end
    endfunction

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : column_loop
            wire [7:0] c0, c1, c2, c3;
            wire [7:0] r0, r1, r2, r3;
            
            assign c0 = in[127 - 32*i -: 8];
            assign c1 = in[119 - 32*i -: 8];
            assign c2 = in[111 - 32*i -: 8];
            assign c3 = in[103 - 32*i -: 8];
            
            assign r0 = gmul(8'h0e, c0) ^ gmul(8'h0b, c1) ^ gmul(8'h0d, c2) ^ gmul(8'h09, c3);
            assign r1 = gmul(8'h09, c0) ^ gmul(8'h0e, c1) ^ gmul(8'h0b, c2) ^ gmul(8'h0d, c3);
            assign r2 = gmul(8'h0d, c0) ^ gmul(8'h09, c1) ^ gmul(8'h0e, c2) ^ gmul(8'h0b, c3);
            assign r3 = gmul(8'h0b, c0) ^ gmul(8'h0d, c1) ^ gmul(8'h09, c2) ^ gmul(8'h0e, c3);
            
            assign out[127 - 32*i -: 8] = r0;
            assign out[119 - 32*i -: 8] = r1;
            assign out[111 - 32*i -: 8] = r2;
            assign out[103 - 32*i -: 8] = r3;
        end
    endgenerate

endmodule

