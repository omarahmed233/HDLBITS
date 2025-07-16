module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 
    reg [4:0] q_next;
    always@(posedge clk) begin
        if(reset)
            q <= 5'h1;
        else
            q <= q_next;
    end
    
    always@(*) begin
         q_next[0] = q[1] ;
         q_next[1] = q[2] ;
         q_next[2] = q[3] ^ q[0];
         q_next[3] = q[4] ;
         q_next[4] = q[0] ;
     end
    

endmodule
