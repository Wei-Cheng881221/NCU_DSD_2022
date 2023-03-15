`timescale 1ns / 1ps

module Lab_1_tb;
    //Input
    reg [1:8] DIP;
    //output
    wire [7:0] Enable;
    wire [0:15] LED;
    wire [7:0] SevenSeg ;
    
    //uut
    Lab_1 uut(
    .SW_DIP(DIP),
    .Enable(Enable),
    .LED(LED),
    .SevenSeg(SevenSeg)
    );
    
initial begin
#100; DIP = 0;
$monitor ("LED output = %b\nSEG output = %b\nAt %t\n", LED, SevenSeg, $time);
//$monitor ("DIP output = %b\n", DIP);

DIP = 8'b01001111;
#100; DIP = 8'b01101110;
#100; DIP = 8'b10010111;
#100; DIP = 8'b10110110;
#100; DIP = 8'b11011011;
#100; DIP = 8'b11111010;

end
endmodule
