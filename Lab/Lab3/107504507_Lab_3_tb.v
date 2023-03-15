`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IPEECS
// Engineer: Wei Cheng
//////////////////////////////////////////////////////////////////////////////////


module Lab_3_tb;
    //Input
    reg reset;
    reg fpga_clock;
    reg ps2_clock;
    reg ps2_data;
    reg [3:0] button;  //S4 S3 S2 S1
    
    //output
    wire [7:0] Enable;
    wire [7:0] SevenSeg_left;
    wire [7:0] SevenSeg_right;
    wire [15:0] LED;
    
    //uut
    Lab_3 uut(
    .reset(reset),
    .fpga_clock(fpga_clock),
    .ps2_clock(ps2_clock),
    .ps2_data(ps2_data),
    .button(button),
    .Enable(Enable),
    .SevenSeg_left(SevenSeg_left),
    .SevenSeg_right(SevenSeg_right),
    .LED(LED)
    );
    
initial begin
    //#100;
    fpga_clock = 1'b0;
    ps2_clock = 1'b0;
    forever 
    #5 begin
        fpga_clock <= ~fpga_clock ;
        ps2_clock <= ~ps2_clock;
    end
end

initial begin
    reset = 1'b1;
    ps2_data = 1'b1;
    button = 4'b0;
    #100; reset = 1'b0;
    #10; reset = 1'b1;
    
    #15;
    ps2_data = 1'b0 ;//START            //c 21
    #10; ps2_data = 1'b1 ;//data0
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;//data7 
    #10; ps2_data = 1'b0 ;//parity check
    #10; ps2_data = 1'b1 ;//stop
    #10; ps2_data = 1'b0 ;//START       //break f0
    #10; ps2_data = 1'b0 ;//data0
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b1 ;//data7 
    #10; ps2_data = 1'b0 ;//parity check
    #10; ps2_data = 1'b1 ;//stop        //325
    #50;//pauese
    ps2_data = 1'b0 ;//START            //s 1b
    #10; ps2_data = 1'b1 ;//data0
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;//data7 
    #10; ps2_data = 1'b0 ;//parity check
    #10; ps2_data = 1'b1 ;//stop
    #10; ps2_data = 1'b0 ;//START       //break f0
    #10; ps2_data = 1'b0 ;//data0
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b0 ;
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b1 ;
    #10; ps2_data = 1'b1 ;//data7 
    #10; ps2_data = 1'b0 ;//parity check
    #10; ps2_data = 1'b1 ;//stop        //585
    #10;
    
    #10; button = 4'b1000;
    #50; button = 4'b0000;
    
    #100; button = 4'b0100;
    #50; button = 4'b0000;
    
    #100; button = 4'b0100;
    #50; button = 4'b0000;
    
    #100; button = 4'b0100;
    #50; button = 4'b0000;
    
    #100; button = 4'b0010;
    #50; button = 4'b0000;
    
    #100; button = 4'b0010;
    #50; button = 4'b0000;
    
    #100; button = 4'b0001;
    #50; button = 4'b0000;
    
    
    
end

endmodule 
