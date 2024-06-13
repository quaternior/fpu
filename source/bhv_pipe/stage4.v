`define exp_max 255
`define exp_bias 127
module FMUL(
	input [7:0] A_exp,
	input [7:0] B_exp,
    input [7:0] primal_exp,
    input [22:0] primal_frac,
    input [35:0] c1,
    input [35:0] c2,
	output [7:0] exp,
	output [23:0] frac,
    //***May be discussed!
    output overflow
    );
    wire [47:0] partial_frac;
    wire [8:0] exp_buffer;

    assign partial_frac = (c1 << 12) + c2;
    assign exp_buffer =  (A_exp + B_exp + partial_frac[47] > `exp_bias) ? A_exp + B_exp + partial_frac[47] - `exp_bias : 0;
    // If Inf/NaN occurs, put primal_exp, else, check overflow, else, put exp buffer.
    // Meaning of partial_frac[47] : If 1<fraction<2, add 0 to exp. But 2<fraction<=4, add 1 to exp and right shift to fraction.
    assign exp = (primal) ? primal_exp
            : (overflow) ? 8'hff
            : exp_buffer[7:0];
   // Same for fraction, but if underflow occured(exp==0) put 0.
    assign frac = (primal) ? primal_frac
            : (overflow) ? 0
            : (exp_buffer==0) ? 0
            : (partial_frac[47]) ? partial_frac[46:23] : partial_frac[45:22];
    assign overflow = exp_buffer[8];
endmodule