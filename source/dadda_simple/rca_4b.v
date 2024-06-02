module rca_4b(
    output [3:0] sum,
    output cout,
    input [3:0] a, b,
    input cin
    );
    wire [3:1]c;
    fa fa_inst[3:0](sum, {cout, c[3:1]}, a, b, {c[3:1], cin});
endmodule
