//No overflow
//CSA
module adder(
    output [39:0] sum,
    input [39:0] A,
    input [39:0] B
);
    wire c;
    wire h=1;
    wire l=0;
    wire [39:32] sum_h, sum_l;
    csa_32b csa0(sum[31:0], c, A[31:0], B[31:0], l);
    csa_8b csa1_h(sum_h[39:32], , A[39:32], B[39:32], h);
    csa_8b csa1_l(sum_l[39:32], , A[39:32], B[39:32], l);
    assign sum[39:32] = c ? sum_h : sum_l;
endmodule