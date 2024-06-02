module ha(
    output sum,
    output cout,
    input A,
    input B
);
    assign {cout, sum} = A + B;
endmodule