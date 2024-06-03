module GP_Generate (
    input [47:0] A,
    input [47:0] B,
    output [47:0] G,
    output [47:0] P
);
    assign G = A & B;  // Generate
    assign P = A | B;  // Propagate
endmodule
