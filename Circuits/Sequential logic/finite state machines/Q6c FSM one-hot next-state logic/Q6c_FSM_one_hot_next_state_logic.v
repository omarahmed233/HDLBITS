module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
   
    localparam a = 6'b000001,b=6'b000010,c=6'b000100,d=6'b001000,e=6'b010000,f=6'b100000;
 
    assign Y2 =( (y[1]) & (~w) );
    assign Y4 =( (y[2]) & (w) ) | ( (y[3]) & (w) ) | ( (y[6]) & (w)) | ( (y[5]) & (w));
    
    
endmodule
