`timescale 1ns / 1ps

module Lab_1(
    input [1:8] SW_DIP,     //[1:3]:position  [4:7]pattern  [8]display control
    output reg [7:0] Enable,
    output reg [0:15] LED = 16'b0,
    output reg [7:0] SevenSeg 
    );
    
reg [1:4] group;
reg [2:0]position;
reg [3:0]pattern;
reg DP;
reg [3:0] SevenShow;
//ID = 107504507

always @(*)
    begin
    position = SW_DIP[1:3];
    pattern = SW_DIP[4:7];
    DP = SW_DIP[8];
    end
	
always @(*)
    if (SW_DIP[1:3] == 3'b000)
        begin
        group = 4'b1100;        //1,2
        end
    else if (SW_DIP[1:3] == 3'b001)
        group = 4'b1010;        //1,3
    else if (SW_DIP[1:3] == 3'b010)
        group = 4'b1001;        //1,4
    else if (SW_DIP[1:3] == 3'b011)
        group = 4'b0110;        //2,3
    else if (SW_DIP[1:3] == 3'b100)
        group = 4'b0101;        //2,4
    else if (SW_DIP[1:3] == 3'b101)
        group = 4'b0011;        //3,4
    else if (SW_DIP[1:3] == 3'b110)
        group = 4'b1110;        //1,2,3
    else if (SW_DIP[1:3] == 3'b111)
        group = 4'b0111;        //2,3,4
         
always@(*)
begin
    LED = 16'b0;
    if (SW_DIP[4] == 1 && group[1] == 1)
        LED[0] = 1;
    if (SW_DIP[5] == 1 && group[1] == 1)
        LED[1] = 1;
    if (SW_DIP[6] == 1 && group[1] == 1)
        LED[2] = 1;
    if (SW_DIP[7] == 1 && group[1] == 1)
        LED[3] = 1;
    if (SW_DIP[4] == 1 && group[2] == 1)
        LED[4] = 1;
    if (SW_DIP[5] == 1 && group[2] == 1)
        LED[5] = 1;
    if (SW_DIP[6] == 1 && group[2] == 1)
        LED[6] = 1;
    if (SW_DIP[7] == 1 && group[2] == 1)
        LED[7] = 1;
    if (SW_DIP[4] == 1 && group[3] == 1)
        LED[8] = 1;
    if (SW_DIP[5] == 1 && group[3] == 1)
        LED[9] = 1;
    if (SW_DIP[6] == 1 && group[3] == 1)
        LED[10] = 1;
    if (SW_DIP[7] == 1 && group[3] == 1)
        LED[11] = 1;
    if (SW_DIP[4] == 1 && group[4] == 1)
        LED[12] = 1;
    if (SW_DIP[5] == 1 && group[4] == 1)
        LED[13] = 1;
    if (SW_DIP[6] == 1 && group[4] == 1)
        LED[14] = 1;
    if (SW_DIP[7] == 1 && group[4] == 1)
        LED[15] = 1; 
end

always @(*)
    if(SW_DIP[8] == 0)  //pattern
        begin
        Enable = 8'b00000010;
        case(SW_DIP[4:7])
            4'b0000 :begin SevenSeg = 8'b0011_1111;    SevenShow = 4'b0000; end  //0
            4'b0001 :begin SevenSeg = 8'b0000_0110;    SevenShow = 4'b0001; end  //1
            4'b0010 :begin SevenSeg = 8'b0101_1011;    SevenShow = 4'b0010; end  //2
            4'b0011 :begin SevenSeg = 8'b0100_1111;    SevenShow = 4'b0011; end  //3
            4'b0100 :begin SevenSeg = 8'b0110_0110;    SevenShow = 4'b0100; end  //4
            4'b0101 :begin SevenSeg = 8'b0110_1101;    SevenShow = 4'b0101; end  //5
            4'b0110 :begin SevenSeg = 8'b0111_1101;    SevenShow = 4'b0110; end  //6
            4'b0111 :begin SevenSeg = 8'b0010_0111;    SevenShow = 4'b0111; end  //7
            4'b1000 :begin SevenSeg = 8'b0111_1111;    SevenShow = 4'b1000; end  //8
            4'b1001 :begin SevenSeg = 8'b0110_1111;    SevenShow = 4'b1001; end  //9
            4'b1010 :begin SevenSeg = 8'b0111_0111;    SevenShow = 4'b1010; end  //a
            4'b1011 :begin SevenSeg = 8'b0111_1100;    SevenShow = 4'b1011; end  //b
            4'b1100 :begin SevenSeg = 8'b0011_1001;    SevenShow = 4'b1100; end  //c
            4'b1101 :begin SevenSeg = 8'b0101_1110;    SevenShow = 4'b1101; end  //d
            4'b1110 :begin SevenSeg = 8'b0111_1001;    SevenShow = 4'b1110; end  //e
            4'b1111 :begin SevenSeg = 8'b0111_0001;    SevenShow = 4'b1111; end  //f
        endcase
        end
    else if (SW_DIP[8] == 1)    //position -7
        begin
        Enable = 8'b00000001;
        case(SW_DIP[1:3])
            3'b000 :begin SevenSeg = 8'b0110_1111;    SevenShow = 4'b1001; end   //9
            3'b001 :begin SevenSeg = 8'b0111_0111;    SevenShow = 4'b1010; end   //a
            3'b010 :begin SevenSeg = 8'b0111_1100;    SevenShow = 4'b1011; end   //b
            3'b011 :begin SevenSeg = 8'b0011_1001;    SevenShow = 4'b1100; end   //c
            3'b100 :begin SevenSeg = 8'b0101_1110;    SevenShow = 4'b1101; end   //d
            3'b101 :begin SevenSeg = 8'b0111_1001;    SevenShow = 4'b1110; end   //e
            3'b110 :begin SevenSeg = 8'b0111_0001;    SevenShow = 4'b1111; end   //f
            3'b111 :begin SevenSeg = 8'b0011_1111;    SevenShow = 4'b0000; end   //0
        endcase
        end
endmodule
