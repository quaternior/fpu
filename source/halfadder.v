module ha(
    output sum,
    output cout,
    input A,
    input B
);
    assign sum = A ^ B;
    assign cout = A & B;
endmodule