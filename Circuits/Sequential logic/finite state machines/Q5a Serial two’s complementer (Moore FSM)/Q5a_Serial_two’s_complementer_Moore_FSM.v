module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    localparam a = 0 , b = 1 ,c = 2;
    reg [1:0] state , next ;
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= a;
        else
            state <= next;
    end
    
    always@(*) begin
        case(state)
            a : next = x ? c:a ;
            b : next = x ? b:c ;
            c : next = x ? b:c ;
            default : next = a;
        endcase
    end
           assign z = state == c;

endmodule
