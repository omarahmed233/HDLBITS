module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q ); 

    reg [511:0] q_next;
    always @(posedge clk) begin
        if(load)
            q <= data ;
        else
            q <= q_next ;        
    end
    always@(*) begin
        int k;
        for(k=1; k<511; k=k+1)
            q_next[k] = ( q[k-1] & (!q[k+1]) ) | (q[k-1] ^ q[k]); 
    end
    
    assign q_next[0] = q[0];
    assign q_next[511] = q[511] | q[510];
  
endmodule
