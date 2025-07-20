module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    localparam a = 0 , b = 1;
    reg state , next ;
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= a;
        else
            state <= next;
    end
    
    always@(*) begin
        case(state)
            a : next = x ? b:a ;
            b : next = b ;
            default : next = a;
        endcase
    end
            assign z = ( (state == a) & (x) ) | ( (state == b) & (~x) ) ;

endmodule
