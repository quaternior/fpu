module csa_32b(
    output [31:0] sum,
    output cout,
    input [31:0] a, b,
    input cin
    );
    wire c;
    wire l=0;
    wire h=1;
    wire c_h, c_l;
    wire [31:16] sum_l, sum_h;
    csa_16b csa_inst0(sum[15:0], c, a[15:0], b[15:0], cin);
    
    csa_16b csa_inst1_h(sum_h, c_h, a[31:16], b[31:16], h);
    csa_16b csa_inst1_l(sum_l, c_l, a[31:16], b[31:16], l);

    assign sum[31:16] = (c) ? sum_h : sum_l;
    assign cout = c ? c_h : c_l;
endmodule
