`define exp_max 255
`define exp_bias 127
module FMUL(
	input [22:0] A_frac,
	input [22:0] B_frac,
	output [35:0] c1
    );
    
    mult partial_prod_1(c1, {1'b1, A_frac}, B_frac[11:0]);
endmodule