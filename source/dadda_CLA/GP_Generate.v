module GP_Generate (
    input [45:0] A,
    input [45:0] B,
    output [45:0] G,
    output [45:0] P
);
    assign G = A & B;  // Generate
    assign P = A | B;  // Propagate
endmodule
