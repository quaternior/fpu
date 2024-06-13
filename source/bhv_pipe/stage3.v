`define exp_max 255
`define exp_bias 127
module FMUL(
	input [22:0] A_frac,
	input [22:0] B_frac,
    output [35:0] c2
    );
    mult partial_prod_2(c2, {1'b1, A_frac}, {1'b1, B_frac[22:12]});
endmodule