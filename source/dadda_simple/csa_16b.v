module csa_16b(
    output [15:0] sum,
    output cout,
    input [15:0] a, b,
    input cin
    );
    wire c;
    wire l=0;
    wire h=1;
    wire c_h, c_l;
    wire [15:8] sum_l, sum_h;
    csa_8b csa_inst0(sum[7:0], c, a[7:0], b[7:0], cin);
    
    csa_8b csa_inst1_h(sum_h, c_h, a[15:8], b[15:8], h);
    csa_8b csa_inst1_l(sum_l, c_l, a[15:8], b[15:8], l);

    assign sum[15:8] = (c) ? sum_h : sum_l;
    assign cout = c ? c_h : c_l;
endmodule
