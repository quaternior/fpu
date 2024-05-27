//No overflow
//CSA
module adder_correct(
    output [39:0] sum,
    input [39:0] A,
    input [39:0] B
);
    assign sum = A + B;
endmodule