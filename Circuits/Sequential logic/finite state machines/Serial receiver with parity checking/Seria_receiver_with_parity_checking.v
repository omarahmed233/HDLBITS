module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    localparam 	Idle = 0,
    			start = 1,
    			data = 2,
    			parity = 3,
    			hold = 4,
    			stop = 5;
    reg [7:0] data_received;
    reg [2:0] state,next;
    reg	[3:0] n;
    wire received;
    wire odd;
    reg parity_en;
    reg odd_reg;
    
    assign received = (n == 4'd8);
    assign done = ((state == stop) && odd_reg) ;
    assign out_byte = done ? data_received : 8'h00;
 
    parity parity1(
        .clk(clk),
        .reset(reset | parity_en ),
        .in(in),
        .odd(odd) 
    ); 
    
    always @(posedge clk) begin
    	if(reset) odd_reg <= 0;
    	else odd_reg <= odd; 
    end
    
    always @(posedge clk) begin
    	if (reset) data_received <= 0;
        else if (next == data)
            data_received[n] <= in;
    end
    
    always @(posedge clk) begin
		if (reset) begin
			n <= 0;
		end
		else begin
			case(next) 
				data : begin
					n = n + 1;
				end
				stop : begin
					n <= 0;
				end
				default : begin
					n <= 0;
				end
			endcase
		end
	end

    //we have synchronous reset and we want to update at stop state
    
    always@(posedge clk) begin
        case(next)
       		Idle : parity_en <= 1;	
			stop : parity_en <= 1;
			default : parity_en <= 0;
		endcase 
    end
    
   
    always@(posedge clk) begin
        if(reset)
            state <= Idle;
        else
            state <= next;
    end
    
    always@(*) begin
        case(state)
            Idle  : next = in ? Idle : start;
            start : next = data;
        	data : begin
                if(received)
                    next = parity;
                else 
                    next = data;
            end
            parity : next = in? stop : hold;
            hold : next = in? Idle : hold;
            stop : next = in? Idle : start;
            default : next = Idle;
        endcase
    end
endmodule
