module regfile_stg2_stg3(
        input clk,
        input nRESET,
        //Stage 3
        input [7:0] A_exp_3,
        input [22:0] A_frac_3,
        input [7:0]B_exp_3,
        input [22:0] B_frac_3,
        input sign_3,
        input primal_3,
        input [7:0] primal_exp_3,
        input [22:0] primal_frac_3,
        input error_3,
        input [35:0] c1_3,
        input [35:0] c2_3,

        //Stage 4
        output reg [7:0] A_exp_4,
        output reg [22:0] A_frac_4,
        output reg [7:0]B_exp_4,
        output reg [22:0] B_frac_4,
        output reg sign_4,
        output reg primal_4,
        output reg [7:0] primal_exp_4,
        output reg [22:0] primal_frac_4,
        output reg error_4,
        output reg [35:0] c1_4,
        output reg [35:0] c2_4
    );

    always@(posedge clk or negedge nRESET) begin
        if(!nRESET) begin
            A_exp_4 <= 0;
            A_frac_4 <= 0;
            B_exp_4 <= 0;
            B_frac_4 <= 0;
            sign_4 <= 0;
            primal_4 <= 0;
            primal_exp_4 <= 0;
            primal_frac_4 <= 0;
            error_4 <= 0;
            c1_4 <= 0;
            c2_4 <= 0;
        end
        else begin
            A_exp_4 <= A_exp_3;
            A_frac_4 <= A_frac_3;
            B_exp_4 <= B_exp_3;
            B_frac_4 <= B_frac_3;
            sign_4 <= sign_3;
            primal_4 <= primal_3;
            primal_exp_4 <= primal_exp_3;
            primal_frac_4 <= primal_frac_3;
            error_4 <= error_3;
            c1_4 <= 0;
            c2_4 <= 0;
        end
    end
endmodule