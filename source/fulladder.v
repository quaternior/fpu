module fa(
    output sum,
    output cout,
    input A,
    input B,
    input cin
);
    wire p, g, l;
    ha ha0(p, g, A, B);
    ha ha1(sum, l, p, cin);
    assign cout = l | g;
endmodule