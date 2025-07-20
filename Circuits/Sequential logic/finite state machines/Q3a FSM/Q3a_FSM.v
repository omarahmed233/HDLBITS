module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    localparam a=0,b=1,c=2,d=3,e=4,f=5,g=6,correct = 7,start = 8 ;
    reg [3:0] state,next;
    
    always@(posedge clk) begin
        if(reset)
            state <= start;
        else
            state <= next ;
    end
    
    always@(*) begin
        case(state) 
            start : next = s ? a:start ;
            a : next = w ? b:c ;
            b : next = w ? d:e ;
            c : next = w ? f:g ;
            d : next = w ? a : correct ;
            e : next = w ? correct : a ;
            f : next = w ? correct : a ;
            g : next = a ;
            correct : next = w ? b:c ;
            default : next = start;
        endcase
    end
            
    assign z = ( (state == correct) ); 

endmodule
