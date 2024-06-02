`timescale 1ns / 1ps

module tb_div(

    );
    reg [20:0] A, B;
    reg [20:0] Y;
    always@(*) begin
        Y <= A / B;
    end
    
    initial begin
        A<=10;
        B<=4;
        #2 $stop;
    end
endmodule
