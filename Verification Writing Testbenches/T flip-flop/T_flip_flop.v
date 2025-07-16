module top_module ();
    reg clk,reset,t;
    wire q;
    
    tff dut(clk,reset,t,q);
    initial begin
        reset = 0;
        t= 0;
        #4 reset = 1;
        #4 reset = 0;
        t = 1;
    end
    
    initial begin
       clk = 0;
        forever begin
            #5 clk = ~clk ;
    	end
    end

endmodule
