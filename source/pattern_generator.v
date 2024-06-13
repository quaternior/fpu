module pattern_generator(Clock,Reset,A,B,Sel,round, start, Error, Overflow, Y, genonly, FIN);
	input Clock, Reset;
	input [31:0] A, B;
	input [1:0] Sel;
    input [1:0] round;
	input start;
    input [31:0] Y;
    input Error, Overflow;
    input genonly;
    input FIN;

    integer cnt, fp;
    initial begin
        if(genonly) begin
            $fmonitor(fp, "%x %x %d %d", A, B, Sel, round);
        end
    end
    
    initial begin
        fp = $fopen("pattern.txt");
    end
    
    always@(FIN) begin
        if(FIN)
            $fclose(fp);
    end

    always@(posedge Clock) begin
        if(!genonly) begin
            if(start)
                cnt = cnt + 1;
            $fwrite(fp, "%x %x %d %d %x", A, B, Sel, round, Y);
        end
    end
endmodule