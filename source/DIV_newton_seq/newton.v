module newton(
    input clk,
    input [23:0] A,
    input [23:0] B,
    output [26:0] frac_temp
);
    // 1. Initializing
    // For better convergence, reference initial value 
    wire [49:0] fullfrac;
    wire [7:0] x0f;
    ROM ROM_inst(B[22:19], x0f);

    // 2. Iterations, 26x24 multiplication
    wire [25:0] x0 = {2'b1, x0f, 16'b0};        //0.xxx
    
    wire [49:0] x1_mul = x0 * B;    //xx.xxxx, O
    wire [25:0] x1_sub = ~x1_mul[48:23] + 1'b1; //x.xxxx => to eliminate the 2 term(may be greater than 2)
    wire [51:0] x1 = x0 * x1_sub;   // xx.xxxx
    
    wire [49:0] x2_mul = x1[50:25] * B;
    wire [25:0] x2_sub = ~x2_mul[48:23] + 1'b1;
    wire [51:0] x2 = x1[50:25] * x2_sub;

    
    wire [49:0] x3_mul = x2[50:25] * B;
    wire [25:0] x3_sub = ~x3_mul[48:23] + 1'b1;
    wire [51:0] x3 = x2[50:25] * x3_sub;    // xx.xxxx

    // 3. Final product
    assign fullfrac = A * x3[50:25];    // xx.xxxx
    assign frac_temp = fullfrac[48:23];     //d_x in ref
endmodule