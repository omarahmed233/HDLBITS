module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    reg [2:0] state,Y ;
    localparam s0 = 0, s1= 1, s2 = 2, s3 = 3, s4 = 4;
    always@(posedge clk) begin
        state <= Y ;
    end
    
    always@(*) begin
        case(y)
            s0 : Y = x ? s1 : s0;
            s1 : Y = x ? s4 : s1;
            s2 : Y = x ? s1 : s2;
            s3 : Y = x ? s2 : s1;
            s4 : Y = x ? s4 : s3;
            default : Y = s0;
        endcase
    end
    assign Y0 = Y[0] ;
    assign z = ( (y == s3) | (y == s4) ) ;

endmodule
