module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    reg [2:0] state,next;
    localparam 	s0 = 0,
    			s1 = 1,
    			s2 = 2,
    			done_receiving = 3;
    // State transition logic (combinational)
    always@(*) begin
        case(state)
            s0 : next = in[3] ? s1 : s0;
            s1 : next = s2;
            s2 : next = done_receiving;
            done_receiving : next = in[3] ? s1 : s0;
            default : next = s0;
        endcase
    end
    // State flip-flops (sequential)
            always@(posedge clk) begin
                if(reset)
                    state <= s0;
                else
                    state <= next;
            end
    // Output logic
    assign done = (state == done_receiving);

endmodule
