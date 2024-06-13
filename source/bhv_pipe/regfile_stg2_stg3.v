module regfile_stg2_stg3(
        input clk,
        input nRESET,
        //Stage 2
        input [7:0] A_exp_2,
        input [22:0] A_frac_2,
        input [7:0]B_exp_2,
        input [22:0] B_frac_2,
        input sign_2,
        input primal_2,
        input [7:0] primal_exp_2,
        input [22:0] primal_frac_2,
        input error_2,
        input [35:0] c1_2,

        //Stage 3
        output reg [7:0] A_exp_3,
        output reg [22:0] A_frac_3,
        output reg [7:0]B_exp_3,
        output reg [22:0] B_frac_3,
        output reg sign_3,
        output reg primal_3,
        output reg [7:0] primal_exp_3,
        output reg [22:0] primal_frac_3,
        output reg error_3,
        output reg [35:0] c1_3
    );

    always@(posedge clk or negedge nRESET) begin
        if(!nRESET) begin
            A_exp_3 <= 0;
            A_frac_3 <= 0;
            B_exp_3 <= 0;
            B_frac_3 <= 0;
            sign_3 <= 0;
            primal_3 <= 0;
            primal_exp_3 <= 0;
            primal_frac_3 <= 0;
            error_3 <= 0;
            c1_3 <= 0;
        end
        else begin
            A_exp_3 <= A_exp_2;
            A_frac_3 <= A_frac_2;
            B_exp_3 <= B_exp_2;
            B_frac_3 <= B_frac_2;
            sign_3 <= sign_2;
            primal_3 <= primal_2;
            primal_exp_3 <= primal_exp_2;
            primal_frac_3 <= primal_frac_2;
            error_3 <= error_2;
            c1_3 <= 0;
        end
    end
endmodule