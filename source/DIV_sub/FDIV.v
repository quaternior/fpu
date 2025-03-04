`define exp_max 255
`define exp_bias 127
module FDIV_sub(
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

	wire [23:0] A_temp = {1'b1, A_frac}; // 1.frac_A
	wire [23:0] B_temp = {1'b1, B_frac}; // 1.frac_B
	wire [24:0] R_frac;
	wire [7:0] R_exp;
	wire [24:0] frac_temp, frac_result;
	
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
	
	
	wire [24:0] O, O1, O2, O3, O4, O5, O6, O7, O8, O9, O10, O11, O12, O13, O14, O15, O16, O17, O18, O19, O20, O21, O22, O23, O24;
	
	part_DIV part_DIV_24 ({1'b0, A_temp}, B_temp, O24, frac_temp[24]); //partial divider
	part_DIV part_DIV_23 (O24, B_temp, O23, frac_temp[23]);
	part_DIV part_DIV_22 (O23, B_temp, O22, frac_temp[22]);
	part_DIV part_DIV_21 (O22, B_temp, O21, frac_temp[21]);
	part_DIV part_DIV_20 (O21, B_temp, O20, frac_temp[20]);
	part_DIV part_DIV_19 (O20, B_temp, O19, frac_temp[19]);
	part_DIV part_DIV_18 (O19, B_temp, O18, frac_temp[18]);
	part_DIV part_DIV_17 (O18, B_temp, O17, frac_temp[17]);
	part_DIV part_DIV_16 (O17, B_temp, O16, frac_temp[16]);
	part_DIV part_DIV_15 (O16, B_temp, O15, frac_temp[15]);
	part_DIV part_DIV_14 (O15, B_temp, O14, frac_temp[14]);
	part_DIV part_DIV_13 (O14, B_temp, O13, frac_temp[13]);
	part_DIV part_DIV_12 (O13, B_temp, O12, frac_temp[12]);
	part_DIV part_DIV_11 (O12, B_temp, O11, frac_temp[11]);
	part_DIV part_DIV_10 (O11, B_temp, O10, frac_temp[10]);
	part_DIV part_DIV_9 (O10, B_temp, O9, frac_temp[9]);
	part_DIV part_DIV_8 (O9, B_temp, O8, frac_temp[8]);
	part_DIV part_DIV_7 (O8, B_temp, O7, frac_temp[7]);
	part_DIV part_DIV_6 (O7, B_temp, O6, frac_temp[6]);
	part_DIV part_DIV_5 (O6, B_temp, O5, frac_temp[5]);
	part_DIV part_DIV_4 (O5, B_temp, O4, frac_temp[4]);
	part_DIV part_DIV_3 (O4, B_temp, O3, frac_temp[3]);
	part_DIV part_DIV_2 (O3, B_temp, O2, frac_temp[2]);
	part_DIV part_DIV_1 (O2, B_temp, O1, frac_temp[1]);
	part_DIV part_DIV_0 (O1, B_temp, O, frac_temp[0]);
	 
	
	assign frac_result = frac_temp << ~frac_temp[24];
	
	assign R_frac = (primal) ? primal_frac : frac_result[23:1]; //1.frac_A / 1.frac_B = 1.frac_R
	assign frac = (overflow | zero) ? 24'h000000 : R_frac;
	
	assign R_exp = (primal) ? primal_exp : A_exp - B_exp - frac_temp[23] + `exp_bias;
	assign exp = (overflow) ? 8'hff : ((zero) ? 8'h00 : R_exp);

	
	
	
	
endmodule	