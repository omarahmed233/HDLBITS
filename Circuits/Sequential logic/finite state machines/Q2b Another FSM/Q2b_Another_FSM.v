module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    localparam start = 0, f1 = 1, a = 2, b = 3, c = 4, d = 5, g11 = 6,g12 = 7,g13 = 8, g2 = 9;
    reg [3:0] state,next;
    
    always@(posedge clk) begin
        if(~resetn)
            state <= start;
        else
            state <= next;
    end
    
    always@(*) begin
        case (state)
            start : next = f1;
            f1 : next = a;
            a : next = x ? b : a ;
            b : next = x ? b : c ;
            c : next = x ? d : a ;
            d : next = y ? g11: g13 ;
            g11 : next = y ? g2 : g13;
            g2 : next = g2;
            g13 : next = y? g11 : g12;
            g12 : next = g12;
            default : next = start;
        endcase
    end
    
    assign f = (state == f1);
    assign g = ( (state == d) | (state == g2) | (state == g11) | (state == g13) ) ;

endmodule
