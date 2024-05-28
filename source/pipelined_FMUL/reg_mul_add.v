module reg_mul_add(
    input clk,
    input reset,
    input w_sign, 
    input w_primal, 
    input [7:0] w_primal_exp, 
    input [22:0] w_primal_frac, 
    input w_error,
    input [47:0] w_partial_frac,
    output reg a_sign, 
    output reg a_primal, 
    output reg [7:0] a_primal_exp, 
    output reg [22:0] a_primal_frac, 
    output reg a_error,
    output reg [47:0] a_partial_frac
);
    always@(posedge clk or negedge reset) begin
        if(!reset) begin
            a_sign <= 0;
            a_primal <= 0;
            a_primal_exp <= 0;
            a_primal_frac <= 0;
            a_error <= 0;
            a_partial_frac <= 0;
        end
        else begin
            a_sign <= w_sign;
            a_primal <= w_primal;
            a_primal_exp <= w_primal_exp;
            a_primal_frac <= w_primal_frac;
            a_error <= w_error;
            a_partial_frac <= w_partial_frac;
        end
    end
endmodule