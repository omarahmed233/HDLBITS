module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah );  

    parameter s0=0, s1=1 , s2 = 2 , s3 = 3;
    reg [1:0] state, next_state;

    
    always @(*) begin
        case(state)
            s0 : next_state = (~ground) ? s2 :( bump_left ? s1 : s0 );
            s1 : next_state = (~ground) ? s3 :( bump_right ? s0 : s1 );
            s2 : next_state = (~ground) ? s2 : s0;
            s3 : next_state = (~ground) ? s3 : s1;
	default : state = s0;    
        endcase
    end
    
    
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= s0;
        else
            state <= next_state;
    end

        assign walk_left = (state == s0);
        assign walk_right = (state == s1);
        assign aaah = (state ==  s2 | state ==  s3);

endmodule


