`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/26 22:57:27
// Design Name: 
// Module Name: tb_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_adder(

    );
    wire sum_ha, cout_ha, sum_fa, cout_fa;
    reg a, b, cin;
    ha ha0(sum_ha, cout_ha, a, b);
    fa fa0(sum_fa, cout_fa, a, b, cin);
    initial begin
        a <= 1;
        b <= 0;
        cin <= 1;
    end
endmodule
