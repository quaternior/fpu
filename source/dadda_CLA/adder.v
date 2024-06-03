//CLA
//No Cout, Cin
module adder (
    input [46:0] A,
    input [46:0] B,
    output [46:0] Sum
);
    wire [46:0] G, P;
    wire [47:0] C;
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

    assign Sum = A ^ B ^ C[46:0]; 
endmodule
