 module part_DIV( //partial divider
	input [24:0] A, 
	input [23:0] B,
	output reg [24:0] O,
	output reg R
);
wire [24:0] B_ext = {1'b0, B}; //24bit extension

always@(*) begin
	if(A>=B_ext) begin 
		O <= (A - B_ext)<<1;
		R <= 1; //quotient = 1
	end
	else begin
		O <= A<<1;
		R <= 0; //quotient = 0
	end
end

endmodule
