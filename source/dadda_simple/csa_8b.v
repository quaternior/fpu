module csa_8b(
    output [7:0] sum,
    output cout,
    input [7:0] a, b,
    input cin
    );
    wire c;
    wire l=0;
    wire h=1;
    wire c_h, c_l;
    wire [7:4] sum_l, sum_h;
    rca_4b rca_inst0(sum[3:0], c, a[3:0], b[3:0], cin);
    
    rca_4b rca_inst1_h(sum_h[7:4], c_h, a[7:4], b[7:4], h);
    rca_4b rca_inst1_l(sum_l[7:4], c_l, a[7:4], b[7:4], l);

    assign sum[7:4] = (c) ? sum_h : sum_l;
    assign cout = c ? c_h : c_l;
endmodule
