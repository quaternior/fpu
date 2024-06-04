module TOP_FMUL(
    output reg [31:0] Y_FF,
    output reg error_FF,
    output reg overflow_FF,
    input clk,
    input [31:0] A_wire,
    input [31:0] B_wire
);
    reg [31:0] A;
    reg [31:0] B;
    wire [31:0] Y;
    wire rd;
    wire error, overflow;
    FMUL FMUL_inst(clk, A[31], A[30:23], A[22:0], B[31], B[30:23], B[22:0], 
        Y[31], Y[30:23], {Y[22:0], rd}, error, overflow);
    
    always@(posedge clk) begin
        A <= A_wire;
        B <= B_wire;
        Y_FF <= Y;
        error_FF <= error;
        overflow_FF <= overflow;
    end
endmodule
