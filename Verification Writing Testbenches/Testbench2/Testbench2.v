module top_module();
    reg clk,in ;
    reg [2:0] s;
    wire out;
    
    q7 dut(clk,in,s,out);
    
    initial begin
       clk = 0;
        forever begin
            #5 clk = ~clk ;
    	end
    end
    
    initial begin
       in = 0;
       s = 3'b010 ;
       #10 s = 3'b110 ;
       #10 s = 3'b010 ;
        in = 1;
       #10 s = 3'b111 ;
        in = 0;
       #10 s = 3'b000 ;
        in = 1;
        #30 in = 0;
    end
        

endmodule
