module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=0, RIGHT=1;
    reg state, next_state;

    
    always @(*) begin
        case ({bump_left ,bump_right })
            2'b00 : next_state = state;
            2'b01 : next_state = LEFT;
            2'b10 : next_state = RIGHT;
            2'b11 : next_state = ~state;
            default : next_state = LEFT ;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
