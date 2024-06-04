module GP_Generate (
    input [39:0] A,
    input [39:0] B,
    output [39:0] G,
    output [39:0] P
);
    assign G = A & B;  // Generate
    assign P = A | B;  // Propagate
endmodule
