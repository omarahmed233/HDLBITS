module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    reg [15:0] arr [0:15];
    reg [255:0] q_next;
    int k;
    int n;
    reg [3:0] row,column,row_plus,row_minus,column_plus,column_minus;
    always@(posedge clk) begin
        if(load) 
            q <= data;
        else
            q <= q_next;         
    end
        
        always@(*) begin
            for(k=0; k<256; k = k+1) begin
            	row = k/16;
            	column = k%16;
                
                if(row == 4'd0) begin
                    row_minus = 4'd15;
                    row_plus = 4'd1;
                end    
                else if(row == 4'd15) begin
                    row_minus = 4'd14;
                    row_plus = 4'd0;
                end
                else begin
                    row_minus = row - 1;
                    row_plus = row + 1;
                end
                ///////////////////////////////////////////
                if(column == 4'd0) begin
                    column_minus = 4'd15;
                    column_plus = 4'd1;
                end    
                else if(column == 4'd15) begin
                    column_minus = 4'd14;
                    column_plus = 4'd0;
                end
                else begin
                    column_minus = column - 1;
                    column_plus = column + 1;
                end
                //////////////////////////////////////////////    
            	n = arr[row][column_plus] + arr[row][column_minus] + arr[row_plus][column] + arr[row_plus][column_plus]
            	+ arr[row_plus][column_minus] + arr[row_minus][column] + arr[row_minus][column_minus] + arr[row_minus][column_plus];
                case(n)
                    32'd0 : q_next[k] = 0;
                    32'd1 : q_next[k] = 0;
                    32'd2 : q_next[k] = q[k];
                    32'd3 : q_next[k] = 1;
                    32'd4 : q_next[k] = 0;
                    32'd5 : q_next[k] = 0;
                    32'd6 : q_next[k] = 0;
                    32'd7 : q_next[k] = 0;
                    default : q_next[k] = 0;
                 endcase
            end            
        end
        
    assign arr[0][15:0]   = q[15:0];
	assign arr[1][15:0]   = q[31:16];
	assign arr[2][15:0]   = q[47:32];
	assign arr[3][15:0]   = q[63:48];
	assign arr[4][15:0]   = q[79:64];
	assign arr[5][15:0]   = q[95:80];
	assign arr[6][15:0]   = q[111:96];
	assign arr[7][15:0]   = q[127:112];
	assign arr[8][15:0]   = q[143:128];
	assign arr[9][15:0]   = q[159:144];
	assign arr[10][15:0]  = q[175:160];
	assign arr[11][15:0]  = q[191:176];
	assign arr[12][15:0]  = q[207:192];
	assign arr[13][15:0]  = q[223:208];
	assign arr[14][15:0]  = q[239:224];
	assign arr[15][15:0]  = q[255:240];

endmodule
