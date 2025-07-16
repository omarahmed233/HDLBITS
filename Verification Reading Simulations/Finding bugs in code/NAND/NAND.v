module top_module (input a, input b, input c, output out);//

    parameter d = 1, e=1;
    wire negout;
    andgate inst1 ( negout, a, b, c,d ,e);
    assign out = ~negout;

endmodule
