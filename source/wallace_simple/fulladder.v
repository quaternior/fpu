module fa(
    output sum,
    output cout,
    input A,
    input B,
    input cin
);
    assign {cout, sum} = A + B + cin;
endmodule