module FMUL_wallace(
	input A_sign,
	input [7:0] A_exp,
	input [22:0] A_frac,
	input B_sign,
	input [7:0] B_exp,
	input [22:0] B_frac,
	output sign, 
    output reg primal, 
    output reg [7:0] primal_exp, 
    output reg [22:0] primal_frac, 
    output reg error,
    output [47:0] partial_frac);

    // wire A_is_nan = &A_exp & |A_frac;
    wire A_is_inf = &A_exp & ~|A_frac;
    wire A_is_zero = ~|A_exp;                   //Since denormalized number is regarded as 0, just consider about exp only.
    // wire B_is_nan = &B_exp & |B_frac;
    wire B_is_inf = &B_exp & ~|B_frac;
    wire B_is_zero = ~|B_exp;

    assign sign = A_sign ^ B_sign;

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
        // else if(A_is_nan | B_is_nan) begin
        //     primal = 1;
        //     primal_exp = 8'hff;
        //     primal_frac = 24'h800000;
        //     error = 1;
        // end
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

    wallace_tree wallace_tree_inst(L7_frac1, L7_frac2, {1'b1, A_frac}, {1'b1, B_frac});

endmodule