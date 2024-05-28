//Wallace-tree version
`define exp_max 255
`define exp_bias 127
module FMUL(
    input clk,
	input A_sign,
	input [7:0] A_exp,
	input [22:0] A_frac,
	input B_sign,
	input [7:0] B_exp,
	input [22:0] B_frac,
	output sign,
	output [7:0] exp,
	output [23:0] frac,
    //***May be discussed!
    output reg error,
    output overflow
    );

    wire w_sign;
    wire w_primal;
    wire [7:0] w_primal_exp;
    wire w_error;
    wire [23:0] w_primal_frac;
    wire [47:0] w_partial_frac;

    
    // Stage 1 : Wallace-tree and exception case
    FMUL_wallace fmul0(
        .A_sign(A_sign)
        .A_exp(A_exp), 
        .A_frac(A_frac), 
        .B_sign(B_sign),
        .B_exp(B_exp), 
        .B_frac(B_frac), 
        .sign(w_sign),
        .primal(w_primal), 
        .primal_exp(w_primal_exp), 
        .primal_frac(w_primal_frac), 
        .error(w_error),
        .partial_frac(w_partial_frac)
    );
    reg_mul_add reg_file0(
        .w_sign(w_sign),
        .w_primal(w_primal), 
        .w_primal_exp(w_primal_exp), 
        .w_primal_frac(w_primal_frac), 
        .w_error(w_error),
        .w_partial_frac(w_partial_frac),
        .a_sign(a_sign),
        .a_primal(a_primal), 
        .a_primal_exp(a_primal_exp), 
        .a_primal_frac(a_primal_frac), 
        .a_error(a_error),
        .a_partial_frac(a_partial_frac),
    );
    
    // Stage 2 : Addition

    FMUL_add fmul1(
        .a_sign(a_sign),
        .a_primal(a_primal), 
        .a_primal_exp(a_primal_exp), 
        .a_primal_frac(a_primal_frac), 
        .a_error(a_error),
        .a_partial_frac(a_partial_frac),
    );
    reg_mul_add reg_file1();

    // For sufficient number of space. If underflow occurs, put 0.
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