module top_module ( );
    
    reg clk ;
    dut dut1 (clk);
    
    initial begin
        clk = 0;
       forever begin
          #5 clk = ~clk; 
       end
    end

endmodule
