// Wallace tree
module mult(
    output [35:0] product,
    input [23:0] A,
    input [11:0] B
);
    assign product = A * B;

endmodule
