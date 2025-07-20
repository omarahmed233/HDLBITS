module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    localparam s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4;
    reg [2:0] state, next;

    // State transition (sequential logic)
    always @(posedge clk) begin
        if (reset)
            state <= s0;        // Reset state to s0
        else
            state <= next;
    end

    // Next state logic (combinational)
    always @(*) begin
        case(state)
            s0 : next = x ? s1 : s0;
            s1 : next = x ? s4 : s1;
            s2 : next = x ? s1 : s2;
            s3 : next = x ? s2 : s1;
            s4 : next = x ? s4 : s3;
            default: next = s0;
        endcase
    end

    // Output logic
    assign z = (state == s3) | (state == s4);

endmodule
