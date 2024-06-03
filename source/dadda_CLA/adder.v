//CLA
//No Cout, Cin
module adder (
    input [47:0] A,
    input [47:0] B,
    output [47:0] Sum
);
    wire [47:0] G, P;
    wire [48:0] C;
    wire Cin = 1'b0;
    GP_Generate gp_gen (
        .A(A),
        .B(B),
        .G(G),
        .P(P)
    );

    CLA_Logic cla_logic (
        .G(G),
        .P(P),
        .Cin(Cin),
        .C(C)
    );

    assign Sum = A ^ B ^ C[47:0]; 
endmodule
