`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IPEECS
// Engineer: Wei-Cheng
//////////////////////////////////////////////////////////////////////////////////


module HW_3_tb;
    //input
    reg clk;
    reg reset;
    reg start;
    reg go_right;
    reg go_left;
    //output
    wire [2:0] NinjaX; wire [3:0] NinjaY;
    wire [3:0] Elevator1Y; wire [3:0] Elevator2Y; wire [3:0] Elevator3Y;
    wire [3:0] Shurikan1Y; wire [3:0] Shurikan2Y; wire [3:0] Shurikan3Y;
    wire touch;
    wire drop;
    wire [6:0] score;
    wire [1:0] chance;
    wire key;
    wire on_Elevator;
    wire [1:0] CS;
    
    HW_3 uut(
    .clk_input(clk),
    .reset(reset),
    .start(start),
    .go_right(go_right), .go_left(go_left),
    .NinjaX(NinjaX), . NinjaY( NinjaY),
    .Elevator1Y(Elevator1Y), .Elevator2Y(Elevator2Y), .Elevator3Y(Elevator3Y),
    .Shurikan1Y(Shurikan1Y), .Shurikan2Y(Shurikan2Y), .Shurikan3Y(Shurikan3Y),
    .touch(touch), .drop(drop), .score(score),
    .chance(chance), .key(key), .on_Elevator(on_Elevator),
    .CS(CS)
    );
    
    initial begin
        #100;
        clk = 1'b1 ;
        forever
        #50 clk = ~clk ;
    end
    
    initial begin
        #100;
        reset = 1'b1; start = 1'b0; go_left = 1'b0; go_right = 1'b0;
        #50;    reset = 1'b0;
        #100;   start = 1'b1;
        #100;   start = 1'b0; go_left = 1'b1;
        #300;   go_left = 1'b0;
        #300;   go_left = 1'b1;
        #300;   go_left = 1'b0; go_right = 1'b1;
        #100;   go_right = 1'b0;
        #100;   go_right = 1'b1;
        #100;   go_right = 1'b0;
        #100;   go_right = 1'b1;
        #200;   go_right = 1'b0;
        #500;   go_right = 1'b1;
        #300;   go_right = 1'b0;
    end 
    
endmodule
