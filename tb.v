module tb;
    reg A_sign;
	reg [7:0] A_exp;
	reg [22:0] A_frac;
	reg B_sign;
	reg [7:0] B_exp;
	reg [22:0] B_frac;

	wire sign;
	wire [7:0] exp;
	wire [23:0] frac;
    //***May be discussed!
    wire error;
    wire overflow;
    
    wire [31:0] result_bit = {sign, exp, frac[23:1]};
    integer fp_pattern, fp_result, r;
    integer i=0;
//    real result_sim;
//    real A_sim;
//    real B_sim;
//    real result;
    reg continue;
    reg [31:0] A;
    reg [31:0] B;
    //IEEE754-to-real converter
    //Result don't considers rounding
//   always@(*) begin
//        A_sim = (A_sign ? -1.0 : 1.0) * (1.0 + A_frac / (2.0 ** 23)) * (2.0 ** (A_exp-127));
//        B_sim = (B_sign ? -1.0 : 1.0) * (1.0 + B_frac / (2.0 ** 23)) * (2.0 ** (B_exp-127));
//        result_sim = A_sim * B_sim;
//   end
//   always@(*) begin
//        result = (sign ? -1.0 : 1.0) * (1.0 + (frac>>1) / (2.0 ** 23)) * (2.0 ** (exp-127));
//   end
   
    FMUL FMUL0(
        .A_sign(A_sign),
        .A_exp(A_exp),
        .A_frac(A_frac),
        .B_sign(B_sign),
        .B_exp(B_exp),
        .B_frac(B_frac),
        .sign(sign),
        .exp(exp),
        .frac(frac),
        .error(error),
        .overflow(overflow)
    );
    initial begin
        fp_result = $fopen("../../../../../result.txt", "w");
        $fmonitor(fp_result, "%d : %h %h %h",i, A, B, result_bit);
    end
    
    initial begin
        fp_pattern = $fopen ("../../../../../pattern.txt", "r");
        continue = 1;
        while(continue) begin
            r = $fscanf(fp_pattern, "%h %h", A, B);
            {A_sign, A_exp, A_frac} = A;
            {B_sign, B_exp, B_frac} = B;
            if(r==-1) begin
                continue = 0;
            end
            else begin
                i = i+1;
            end
            #2;
        end
        $fclose(fp_pattern);
        $fclose(fp_result);
        $stop;
    end
    
    
    
    
    
//    initial begin
//        // 0*0 = 0
//        {A_sign, A_exp, A_frac} <= 32'b00000000000000000000000000000000;
//        {B_sign, B_exp, B_frac} <= 32'b00000000000000000000000000000000;
//        #2;
//        // -240*-120=45,184
//        // 0_10001101_11000010000000000000000
//        {A_sign, A_exp, A_frac} <= 32'b1_10000110_11100000000000000000000;
//        {B_sign, B_exp, B_frac} <= 32'b1_10000101_11100000000000000000000;
//        #2;
//        // 2.0078125 * 4.015625 = 
//		{A_sign, A_exp, A_frac} = 32'b0_10000000_00000001000000000000000;
//        {B_sign, B_exp, B_frac} = 32'b0_10000001_00000001000000000000000;
//        #2;
//        // Inf * Inf
//		{A_sign, A_exp, A_frac} = 32'b0_11111111_00000000000000000000000;
//        {B_sign, B_exp, B_frac} = 32'b0_11111111_00000000000000000000000;
//        #2;
//        // Inf * -Inf
//		{A_sign, A_exp, A_frac} = 32'b0_11111111_00000000000000000000000;
//        {B_sign, B_exp, B_frac} = 32'b1_11111111_00000000000000000000000;
//        #2;
//        // Inf * 0
//		{A_sign, A_exp, A_frac} = 32'b0_11111111_00000000000000000000000;
//        {B_sign, B_exp, B_frac} = 32'b0_00000000_00000000000000000000000;
//        #2;
//        // Inf * NaN
//		{A_sign, A_exp, A_frac} = 32'b0_11111111_00000000000000000000000;
//        {B_sign, B_exp, B_frac} = 32'hffc00000;
//        #2;
//        // NaN * -240
//        {A_sign, A_exp, A_frac} = 32'hffc00000;
//        {B_sign, B_exp, B_frac} = 32'b1_10000110_11100000000000000000000;
//        #2;
//        // Overflow(William song)
//        {A_sign, A_exp, A_frac} = 32'b01100010100101011001111010110010;
//        {B_sign, B_exp, B_frac} = 32'b01011110001100011010001010111100;
//        #2;
//        // Underflow
//        {A_sign, A_exp, A_frac} = 32'b10011001001000001000101110011100;
//        {B_sign, B_exp, B_frac} = 32'b00100001101111111101100010011101;
//        #2;
//        $stop;
//    end
endmodule