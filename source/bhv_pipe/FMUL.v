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
    wire [47:0] partial_frac;
    wire [8:0] exp_buffer;
    reg primal;
    reg [7:0] primal_exp;
    reg [23:0] primal_frac;
    wire A_is_nan = &A_exp & |A_frac;
    wire A_is_inf = &A_exp & ~|A_frac;
    wire A_is_zero = ~|A_exp;                   //Since denormalized number is regarded as 0, just consider about exp only.
    wire B_is_nan = &B_exp & |B_frac;
    wire B_is_inf = &B_exp & ~|B_frac;
    wire B_is_zero = ~|B_exp;
    
    // Check NaN, inf, 0
    always@(*) begin
        // 1. Exception cases handling
        // inf * inf = inf
        // NaN * x = NaN
        // x * NaN = NaN
        // inf * 0 = NaN
        // 0 * inf = NaN
        // 0 * x = 0 (NaN, inf case is filtered by priority)
        // x * 0 = 0
        if(A_is_inf & B_is_inf) begin
            primal = 1;
            primal_exp = 8'hff;
            primal_frac = 0;
            error = 0;
        end
        else if(A_is_nan | B_is_nan) begin
            primal = 1;
            primal_exp = 8'hff;
            primal_frac = 24'h800000;
            error = 1;
        end
        else if( (A_is_inf & B_is_zero) || (A_is_zero & B_is_inf) ) begin
            primal = 1;
            primal_exp = 8'hff;
            primal_frac = 24'h800000;
            error = 1;
        end
        else if( A_is_zero | B_is_zero ) begin
            primal = 1;
            primal_exp = 0;
            primal_frac = 0;
            error = 0;
        end
        else begin
            primal = 0;
            primal_exp = primal_exp;
            primal_frac = primal_frac;
            error = 0;
        end
    end
    // 2. Fraction multiplying
    wire [36:0] c1, c2;
    mult partial_prod_1(c1, {1'b1, A_frac}, B_frac[11:0]);
    mult partial_prod_2(c2, {1'b1, B_frac[22:12]});
    assign partial_frac = (c1 << 12) + c2;
    // 3. Assign
    assign sign = A_sign ^ B_sign;
    // For sufficient number of space. If underflow occurs, put 0.
    // Can be optimized??
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