// Target cycle : 5 cycle
module mult_correct(
    output [47:0] Y,
    input [23:0] A,
    input [23:0] B
);
    assign Y = A * B;
endmodule