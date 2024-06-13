module regfile_stg1_stg2(
        input clk,
        input nRESET,
        //Stage 1
        input [7:0] A_exp_1,
        input [22:0] A_frac_1,
        input [7:0] B_exp_1,
        input [22:0] B_frac_1,
        input sign_1,
        input primal_1,
        input [7:0] primal_exp_1,
        input [22:0] primal_frac_1,
        input error_1,

        output reg [7:0] A_exp_2,
        output reg [22:0] A_frac_2,
        output reg [7:0]B_exp_2,
        output reg [22:0] B_frac_2,
        output reg sign_2,
        output reg primal_2,
        output reg [7:0] primal_exp_2,
        output reg [22:0] primal_frac_2,
        output reg error_2
    );

    always@(posedge clk or negedge nRESET) begin
        if(!nRESET) begin
            A_exp_2 <= 0;
            A_frac_2 <= 0;
            B_exp_2 <= 0;
            B_frac_2 <= 0;
            sign_2 <= 0;
            primal_2 <= 0;
            primal_exp_2 <= 0;
            primal_frac_2 <= 0;
            error_2 <= 0;
        end
        else begin
            A_exp_2 <= A_exp_1;
            A_frac_2 <= A_frac_1;
            B_exp_2 <= B_exp_1;
            B_frac_2 <= B_frac_1;
            sign_2 <= sign_1;
            primal_2 <= primal_1;
            primal_exp_2 <= primal_exp_1;
            primal_frac_2 <= primal_frac_1;
            error_2 <= error_1;
        end
    end
endmodule