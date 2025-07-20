module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    reg [7:0] data_received;
    localparam 	Idle = 0,
    			start = 1,
    			data = 2,
    			hold = 3,
    			stop = 4;
    reg [2:0] state,next;
    reg	[3:0] n;
    wire received;
    
    assign received = (n == 4'd8);
    assign done = ((state == stop)) ;
    assign out_byte = done ? data_received : 8'h00;
    
    always@(posedge clk) begin
        if(reset)
            state <= Idle;
        else
            state <= next;
    end
    
     always@(posedge clk) begin
     	if(reset) begin
            data_received <= 8'd0;
            n <= 4'd0;
        end
        else if(next == data) begin
        	data_received[n] <= in;
        	n <= n+1;
        end
         else if(next == start) begin
         	data_received <= 8'd0;
            n <= 4'd0; 
         end
         else
             n <= 4'd0;
     end
    
    always@(*) begin
        case(state)
            Idle  : next = in ? Idle : start;
            start : begin
               next = data;
            end
        	data : begin
                if(received)
                    next = in? stop : hold;
                else begin
                    next = data;
                end
            end
            hold : next = in? Idle : hold;
            stop : next = in? Idle : start;
            default : next = Idle;
        endcase
    end
endmodule
