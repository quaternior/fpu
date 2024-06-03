module GP_Generate (
    input [46:0] A,
    input [46:0] B,
    output [46:0] G,
    output [46:0] P
);
    assign G = A & B;  // Generate
    assign P = A | B;  // Propagate
endmodule
