module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    
    parameter A=1, B=2, C=4, D=8;
    parameter X=0, Y=1, Z=2, K=3;
    
    reg[3:0] state,next_state ;
    
    assign next_state[X] = (state[X] & ~in) | (state[Z] & ~in);
    assign next_state[Y] = (state[X] & in) | (state[Y] & in) | (state[K] & in);
    assign next_state[Z] = (state[Y] & ~in) | (state[K] & ~in);
    assign next_state[K] = (state[Z] & in);

    assign out = state[K];
    
    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= 1;
        else
            state <= next_state ;
    end

endmodule
