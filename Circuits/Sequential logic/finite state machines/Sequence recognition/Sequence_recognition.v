module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    localparam s0 = 0, s1 = 1 , s2 = 2 , s3 = 3 , s4 = 4 , s5 = 5 , s6 = 6 , s7 = 7,discarded = 8, flaged = 9;
    reg [3:0] state,next;
    
    always@(posedge clk) begin
        if(reset)
            state <= s0;
        else
            state <= next;
    end
            
    always@(*) begin
        case(state)
            s0: next = in? s1:s0;
            s1: next = in? s2:s0;
            s2: next = in? s3:s0;
            s3: next = in? s4:s0;
            s4: next = in? s5:s0;
            s5: next = in? s6:discarded;
            s6: next = in? s7:flaged;
            s7: next = in? s7:s0;
            flaged: next = in? s1:0;
            discarded: next = in? s1:0;
            default : next = s0;
        endcase
    end
            
    assign err = (state == s7);
    assign disc = (state == discarded);
    assign flag = (state == flaged);

endmodule
