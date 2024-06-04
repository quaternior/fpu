module CLA_Logic (
    input [39:0] G,
    input [39:0] P,
    input Cin,
    output [40:0] C
);
    assign C[0] = Cin;
    genvar i;
    generate
        for (i = 0; i < 40; i = i + 1) begin : carry_gen
            assign C[i + 1] = G[i] | (P[i] & C[i]);
        end
    endgenerate
endmodule
