module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
     
    reg[3:0] Q,Q_next ;
    always@(posedge clk) begin
        if(!resetn)
            Q <= 0;
        else
            Q <= Q_next ;
    end
    
    always@(*) begin
        Q_next[0] = Q[1];
        Q_next[1] = Q[2];
        Q_next[2] = Q[3];
        Q_next[3] = in;
    end
    
    assign out = Q[0];

endmodule
