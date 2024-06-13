module ROM(
    input [3:0] b,
    output reg [7:0] x0
);
    always @(b) begin
        case(b)
            4'h0: x0 = 8'hff;
            4'h1: x0 = 8'hdf;
            4'h2: x0 = 8'hc3; 
            4'h3: x0 = 8'haa;
            4'h4: x0 = 8'h93; 
            4'h5: x0 = 8'h7f;
            4'h6: x0 = 8'h6d; 
            4'h7: x0 = 8'h5c;
            4'h8: x0 = 8'h4d; 
            4'h9: x0 = 8'h3f;
            4'ha: x0 = 8'h33; 
            4'hb: x0 = 8'h27;
            4'hc: x0 = 8'h1c;
            4'hd: x0 = 8'h12;
            4'he: x0 = 8'h08; 
            4'hf: x0 = 8'h00;
            4'hc: x0 = 8'h1c; 
            4'hd: x0 = 8'h12;
            4'he: x0 = 8'h08; 
            4'hf: x0 = 8'h00;
        endcase
    end

endmodule
