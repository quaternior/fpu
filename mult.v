module mult(
    output [47:0] Y,
    input [24:0] A,
    input [24:0] B
);
    assign Y = A * B;
endmodule