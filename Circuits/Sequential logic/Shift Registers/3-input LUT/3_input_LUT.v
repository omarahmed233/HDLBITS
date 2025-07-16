module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output reg Z  // `Z` needs to be declared as `reg` since it's assigned in an always block
);
    
    reg [7:0] Q, Q_next;

    // Sequential logic for updating the shift register
    always @(posedge clk) begin
        if (enable)
            Q <= Q_next;
    end
    
    // Combinational logic for next state computation (shifting)
    always @(*) begin
        Q_next = Q;  // Ensure all bits are assigned, avoiding latch issues
        Q_next[7:1] = Q[6:0];  // Shift left
        Q_next[0] = S;  // New input enters LSB
    end
    
    // Output logic based on selector inputs
    always @(*) begin
        case ({A, B, C})
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0;  // Safety default case
        endcase
    end

endmodule
