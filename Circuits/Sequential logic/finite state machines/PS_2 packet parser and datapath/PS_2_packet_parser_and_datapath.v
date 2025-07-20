module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
	
    reg [7:0] first_byte;
    reg [7:0] second_byte;
    reg [7:0] third_byte;
    reg [23:0] received_bytes;
    reg [2:0] state,next;
    localparam 	s0 = 0,
    			s1 = 1,
    			s2 = 2,
    			done_receiving = 3;
    // State transition logic (combinational)
    always@(*) begin
        case(state)
            s0 : begin
                next = in[3] ? s1 : s0;
                first_byte = in;
            end
            s1 : begin
                next = s2;
                received_bytes[23:16] = first_byte;
                second_byte = in;
            end
            s2 : begin
                next = done_receiving;
                received_bytes[15:8] = second_byte;
                third_byte = in;
            end
            done_receiving : begin
                next = in[3] ? s1 : s0;
                received_bytes[7:0] = third_byte;
                first_byte = in;
            end
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
	assign out_bytes = done ? received_bytes : 24'h0;

endmodule
