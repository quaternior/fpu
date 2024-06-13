/*
Purpose
1) Check area(does area significantly increases?)
2) Check timing(does timing significantly increases?)
/
*/

`define exp_max 255
`define exp_bias 127
module FMUL(
    input clk,
    input nRESET,
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
    //Wire : stage 1
    wire [7:0] A_exp_1;
    wire [22:0] A_frac_1;
    wire [7:0] B_exp_1;
    wire [22:0] B_frac_1;
    wire sign_1;
    wire primal_1;
    wire [7:0] primal_exp_1;
    wire [22:0] primal_frac_1;
    wire error_1;
    //Wire : stage 2
    wire [7:0] A_exp_2;
    wire [22:0] A_frac_2;
    wire [7:0]B_exp_2;
    wire [22:0] B_frac_2;
    wire sign_2;
    wire primal_2;
    wire [7:0] primal_exp_2;
    wire [22:0] primal_frac_2;
    wire error_2;
    wire [35:0] c1_2;
    //Wire : stage 3
    wire [7:0] A_exp_3;
    wire [22:0] A_frac_3;
    wire [7:0]B_exp_3;
    wire [22:0] B_frac_3;
    wire sign_3;
    wire primal_3;
    wire [7:0] primal_exp_3;
    wire [22:0] primal_frac_3;
    wire error_3;
    wire [35:0] c1_3;
    wire [35:0] c2_3;
    //Wire : Stage 4
    wire [7:0] A_exp_4;
    wire [22:0] A_frac_4;
    wire [7:0]B_exp_4;
    wire [22:0] B_frac_4;
    wire sign_4;
    wire primal_4;
    wire [7:0] primal_exp_4;
    wire [22:0] primal_frac_4;
    wire error_4;
    wire [35:0] c1_4;
    wire [35:0] c2_4;
    //Stage 1
    stage1 stage1_i(
        //input
        .A_sign(A_sign),
        .A_exp(A_exp),
        .A_frac(A_frac),
        .B_sign(B_sign),
        .B_exp(B_exp),
        .B_frac(B_frac),
        //output
        .sign(sign_1),
        .primal(primal_1),
        .primal_exp(primal_exp_1),
        .primal_frac(primal_frac_1),
        .error(error_1)
    );
    //Pipeline register
    regfile_stg1_stg2 regfile_1(
        .clk(clk),
        .nRESET(nRESET),
        //Stage 1
        .A_exp_1(A_exp),
        .A_frac_1(A_frac),
        .B_exp_1(B_exp),
        .B_frac_1(B_frac),
        .sign_1(sign_1),
        .primal_1(primal_1),
        .primal_exp_1(primal_exp_1),
        .primal_frac_1(primal_frac_1),
        .error_1(error_1),
        //Stage 2
        .A_exp_2(A_exp_2),
        .A_frac_2(A_frac_2),
        .B_exp_2(B_exp_2),
        .B_frac_2(B_frac_2),
        .sign_2(sign_2),
        .primal_2(primal_2),
        .primal_exp_2(primal_exp_2),
        .primal_frac_2(primal_frac_2),
        .error_2(error_2),
    );
    //Stage2
    stage2 stage2_i(
        //input
        .A_frac(A_frac_2),
        .B_frac(B_frac_2),
        //output
        .c1(c1_2)
    );
    regfile_stg1_stg2 regfile_2(
        .clk(clk),
        .nRESET(nRESET),
        //Stage 2
        .A_exp_2(A_exp_2),
        .A_frac_2(A_frac_2),
        .B_exp_2(B_exp_2),
        .B_frac_2(B_frac_2),
        .sign_2(sign_2),
        .primal_2(primal_2),
        .primal_exp_2(primal_exp_2),
        .primal_frac_2(primal_frac_2),
        .error_2(error_2),
        .c1_2(c1_2),
        //Stage 3
        .A_exp_3(A_exp_3),
        .A_frac_3(A_frac_3),
        .B_exp_3(B_exp_3),
        .B_frac_3(B_frac_3),
        .sign_3(sign_3),
        .primal_3(primal_3),
        .primal_exp_3(primal_exp_3),
        .primal_frac_3(primal_frac_3),
        .error_3(error_3),
        .c1_3(c1_3)
    );
    //Stage 3
    stage3 stage3_i(
        //input
        .A_frac(A_frac_3),
        .B_frac(B_frac_3),
        //output
        .c2(c2_3)
    );
    regfile_stg3_stg4 regfile_3(
        .clk(clk),
        .nRESET(nRESET),
        //Stage 3
        .A_exp_3(A_exp_3),
        .A_frac_3(A_frac_3),
        .B_exp_3(B_exp_3),
        .B_frac_3(B_frac_3),
        .sign_3(sign_3),
        .primal_3(primal_3),
        .primal_exp_3(primal_exp_3),
        .primal_frac_3(primal_frac_3),
        .error_3(error_3),
        .c1_3(c1_3),
        .c2_3(c2_3),
        //Stage 4
        .A_exp_4(A_exp_4),
        .A_frac_4(A_frac_4),
        .B_exp_4(B_exp_4),
        .B_frac_4(B_frac_4),
        .sign_4(sign_4),
        .primal_4(primal_4),
        .primal_exp_4(primal_exp_4),
        .primal_frac_4(primal_frac_4),
        .error_4(error),
        .c1_4(c1_4),
        .c2_4(c2_4)
    );
    //Stage 4
    stage4 stage4_i(
        //input
        .A_exp(A_exp_4),
        .B_exp(B_exp_4),
        .primal(primal_4),
        .primal_exp(primal_exp_4),
        .primal_frac(primal_frac_4),
        .c1(c1_4),
        .c2(c2_4),
        //output
        .sign(sign),
        .exp(exp),
        .frac(frac),
        .overflow(overflow)
    );
endmodule