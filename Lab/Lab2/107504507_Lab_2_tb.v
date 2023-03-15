`timescale 1ns / 1ps

module Lab_2_tb;
    //Input
    reg [1:8] DIP;
    reg clk;
    reg reset;
    //output
    wire [7:0] Enable;
    wire [0:15] LED;
    wire [7:0] SevenSeg;
    
    //uut
    Lab_2 uut(
    .SW_DIP(DIP),
    .clk_input(clk),
    .rst(reset),
    .Enable(Enable),
    .LED(LED),
    .SevenSeg(SevenSeg)
    );
    
    //reg speed; 
    //reg [3:0] mode;
    //reg [3:0] pattern;
    //reg [1:0] times;
    
initial begin
    #100;
    clk = 1'b0;
    forever
    #5 clk = ~clk ;
end

initial
    begin
    #100;
    
    DIP = 8'b1001_1110;
    #10;
    reset=0;
    #10;
    reset=1;
    #600;
    reset=0;
    #10;
    DIP = 8'b0101_1111;
    reset=1;
    #600;
    $finish;
    end

endmodule  
