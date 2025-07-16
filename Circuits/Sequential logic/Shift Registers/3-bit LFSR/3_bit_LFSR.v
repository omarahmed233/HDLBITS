module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    reg [2:0] Q_next;
    always@(posedge KEY) begin
    	LEDR <= Q_next ;
    end
    
    always@(*) begin
        Q_next[0] = KEY ? SW[0] : LEDR[2];
        Q_next[1] = KEY ? SW[1] : LEDR[0];
        Q_next[2] = KEY ? SW[2] : LEDR[1] ^ LEDR[2];
    end
    
endmodule
