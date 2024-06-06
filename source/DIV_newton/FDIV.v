//division ver.2
`define exp_max 255
`define exp_bias 127
module FDIV(
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
	output reg error,
	output overflow
);

	wire [23:0] R_frac;
	wire [7:0] R_exp;
	wire [26:0] frac_temp, frac_result;
	
	wire A_is_zero = ~(|A_exp | |A_frac); // A = 0 case
	wire A_is_inf = &A_exp & ~|A_frac; // A = inf case
	
	wire B_is_zero = ~(|B_exp | |B_frac); // B = 0 case
	wire B_is_inf = &B_exp & ~|B_frac; // B = inf case`
	wire zero;
	
	reg primal; //exception variable
  reg [7:0] primal_exp;
  reg [23:0] primal_frac;

	
	// NAN or not NAN phase
	always@(*) begin
		if((A_is_zero & B_is_zero) | (A_is_inf & B_is_inf)) begin
			primal = 1; //exception on
			primal_exp = 8'hff;
			primal_frac = 8'h11; //non zero is ok
			error = 1;
		end
		else if (~A_is_zero & B_is_zero) begin
			primal = 1;
			primal_exp = 8'hff;
			primal_frac = 8'h00;
			error = 0;
		end

		else begin
			primal = 0; //exception off
			primal_exp = primal_exp;
			primal_frac = primal_frac;
			error = 0;
		end
	end
	
	// assign phase
	assign sign = A_sign ^ B_sign;
	assign overflow = (A_is_inf & ~B_is_inf);
	assign zero = (~A_is_inf & B_is_inf);
	
	
	newton newton_inst(
		.clk(clk),
		.A({1'b1, A_frac}),
		.B({1'b1, B_frac}),
		.frac_temp(frac_temp)
	);
	assign frac_result = frac_temp << ~frac_temp[26];
	
	assign R_frac = (primal) ? primal_frac : frac_result[24:1]; //1.frac_A / 1.frac_B = 1.frac_R
	assign frac = (overflow | zero) ? 24'h000000 : {R_frac[23:1] + R_frac[0], 1'b0};   //Rounding for test
	
	assign R_exp = (primal) ? primal_exp : A_exp - B_exp - ~frac_temp[26] + `exp_bias;
	assign exp = (overflow) ? 8'hff : ((zero) ? 8'h00 : R_exp);

	
	
	
	
endmodule
	
	

