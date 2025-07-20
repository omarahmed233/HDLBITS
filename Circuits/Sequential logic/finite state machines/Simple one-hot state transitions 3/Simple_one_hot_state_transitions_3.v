module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=1, B=2, C=4, D=8;
    parameter X=0, Y=1, Z=2, K=3;
    

    assign next_state[X] = (state[X] & ~in) | (state[Z] & ~in);
    assign next_state[Y] = (state[X] & in) | (state[Y] & in) | (state[K] & in);
    assign next_state[Z] = (state[Y] & ~in) | (state[K] & ~in);
    assign next_state[K] = (state[Z] & in);

    assign out = state[K];

endmodule
