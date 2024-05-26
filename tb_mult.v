module tb_mult();
    reg [23:0] A, B;
    wire [47:0] product;
    mult mult0(product, A, B);
    initial begin
        A <= 7254;
        B <= 6395;
        #2 $finish;
    end

endmodule