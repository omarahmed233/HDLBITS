module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);// 
    
    parameter A=0, B=1; 
    reg state, next_state;
///////////////////////////////////////////////////////////
   always @(*) begin 
        case (state)
            A: next_state = (in) ? A : B; // Stay in A if in=1, else go to B
            B: next_state = (in) ? B : A; // Stay in B if in=1, else go to A
            default: next_state = B;
        endcase
    end
/////////////////////////////////////////////////////////////
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= B;
        else
            state <= next_state ;
    end
    
/////////////////////////////////////////////////////////////   
    assign out = (state == B);
    

    // Output logic
    // assign out = (state == ...);

endmodule
