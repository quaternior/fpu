//40 bit CLA
//No Cout, Cin
module adder (
    input [39:0] A,
    input [39:0] B,
    output [39:0] Sum
);
    wire [39:0] G, P;
    wire [40:0] C;
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

    assign Sum = A ^ B ^ C[39:0]; 
endmodule
