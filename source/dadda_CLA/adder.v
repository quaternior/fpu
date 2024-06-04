//CLA
//No Cout, Cin
module adder (
    input [45:0] A,
    input [45:0] B,
    output [45:0] Sum,
    output Cout
);
    wire [45:0] G, P;
    wire [46:0] C;
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

    assign Sum = A ^ B ^ C[45:0]; 
    assign Cout = C[46];
endmodule
