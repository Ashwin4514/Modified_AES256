`timescale 1ns / 1ps

module chacha20_prng(
    input [255:0] seed,        // 256-bit seed (fixed seed)
    input [31:0] round_number,  // 4-bit round number (nonce, 14 rounds)
    output [127:0] random      // 128-bit random output
);
    wire [255:0] round_seed;   // Unique seed for each round
    

    // Generate unique round seed by XORing seed with round number in a different way for each state
    assign round_seed[255:224] = seed[255:224] ^ {round_number, round_number, round_number, round_number}; 
    assign round_seed[223:192] = seed[223:192] ^ {round_number, round_number, round_number, round_number}; 
    assign round_seed[191:160] = seed[191:160] ^ {round_number, round_number, round_number, round_number}; 
    assign round_seed[159:128] = seed[159:128] ^ {round_number, round_number, round_number, round_number}; 
    assign round_seed[127:96]  = seed[127:96]  ^ {round_number, round_number, round_number, round_number}; 
    assign round_seed[95:64]   = seed[95:64]   ^ {round_number, round_number, round_number, round_number}; 
    assign round_seed[63:32]   = seed[63:32]   ^ {round_number, round_number, round_number, round_number}; 
    assign round_seed[31:0]    = seed[31:0]    ^ {round_number, round_number, round_number, round_number}; 

    // State matrix (4 32-bit values)
    wire [31:0] state0, state1, state2, state3;

    // Initial state setup (mix round_seed to generate pseudo-random values)
    assign state0 = round_seed[255:224] + round_number;
    assign state1 = round_seed[223:192] ^ round_number;
    assign state2 = round_seed[191:160] + round_number;
    assign state3 = round_seed[159:128] ^ round_number;

    // Mixing function (shift, add, xor)
    wire [31:0] temp0, temp1, temp2, temp3;
    assign temp0 = state0 + state1;
    assign temp1 = (state1 ^ temp0) << 16 | (state1 ^ temp0) >> 16;  // Rotate left by 16
    assign temp2 = state2 + state3;
    assign temp3 = (state3 ^ temp2) << 12 | (state3 ^ temp2) >> 20;  // Rotate left by 12

    wire [31:0] mix0, mix1, mix2, mix3;
    assign mix0 = temp0 + temp3;
    assign mix3 = (temp3 ^ mix0) << 8 | (temp3 ^ mix0) >> 24;  // Rotate left by 8
    assign mix1 = temp1 + temp2;
    assign mix2 = (temp2 ^ mix1) << 7 | (temp2 ^ mix1) >> 25;  // Rotate left by 7

    // Final output (128 bits)
    assign random = {mix0, mix1, mix2, mix3};

endmodule

