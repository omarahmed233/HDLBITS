module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 

    always@(posedge clk or posedge areset) begin
        if(areset)
            q=0;
        //////////////////////////////////////
        else begin
            if(load) begin
                q[0] <= data[0] ;
        		q[1] <= data[1] ;
        		q[2] <= data[2] ;
        		q[3] <= data[3] ;
            end
         //////////////////////////////////////
            else if(ena) begin
                q[0] <= q[1] ;
        		q[1] <= q[2] ;
        		q[2] <= q[3] ;
        		q[3] <= 0 ;
            end
        end
     end
    
    
    
endmodule
