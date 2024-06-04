module pattern_generator(Clock,Reset,A,B,Sel,round, start, Error, Overflow, Y, genonly);
	input Clock, Reset;
	input [31:0] A, B;
	input [1:0] Sel;
    input [1:0] round;
	input start;
    input [31:0] Y;
    input Error, Overflow;
    input genonly;

    integer cnt, fp;
    initial begin
        if(genonly) begin
            $fmonitor(fp, "%x %x %d", A, B, Sel);
        end
    end
    
    initial begin
        fp = $fopen("pattern.txt");
        #1000 $fclose(fp);
    end

    always@(posedge Clock) begin
        if(!genonly) begin
            if(start)
                cnt = cnt + 1;
            $fwrite(fp, "%x %x %d %x", A, B, Sel, Y);
        end
    end
endmodule