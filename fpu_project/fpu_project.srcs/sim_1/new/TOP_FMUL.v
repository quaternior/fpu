module TOP_FMUL(
    input clk,
    input [31:0] A_wire,
    input [31:0] B_wire,
    output reg [31:0] Y,
    output overflow,
    output error
);
    reg [31:0] A;
    reg [31:0] B;
    wire [31:0] Y_wire;
    FMUL FMUL0(clk, A[31], A[30:23], A[22:0], 
        B[31], B[30:23], B[22:0],
        Y_wire[31], Y_wire[30:23], Y_wire[22:0], error, overflow);
    always@(posedge clk) begin
        A <= A_wire;
        B <= B_wire;
        Y <= Y_wire;
    end
endmodule