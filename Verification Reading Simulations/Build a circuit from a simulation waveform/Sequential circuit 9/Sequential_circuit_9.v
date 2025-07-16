module top_module (
    input clk,
    input a,
    output [3:0] q );

    reg [3:0] q_next ;
    wire en;
    
    always@(posedge clk) begin
        if(a)
            q <= 4 ;
        
        else begin
            if(en)
            	q <= q+1 ;
            else
            	q <= 0;
        end
        
    end
    
    assign en = ~(q == 6);
endmodule
