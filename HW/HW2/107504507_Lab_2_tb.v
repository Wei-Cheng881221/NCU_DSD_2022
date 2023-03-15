`timescale 1ns / 1ps

module Lab_2_tb;
    //Input
    reg Dis;
    reg CLK;
    reg RES;
    wire [3:0] DEC;
    
    //UUT
    Lab_2 uut(
    .dis(Dis),
    .reset(RES),
    .clk(CLK),
    .DEC(DEC)
    );
    
initial begin
#100; Dis = 0; CLK = 0; RES = 1;
$monitor ("Dec = %d at time %t", DEC, $time);
    // Wait 100 ns for global reset to finish
    // Add stimulus here
#10; RES = 0 ;  #10; RES = 1;
#160; Dis = 1;

end

always @(*)
begin
    #5; CLK <= ~CLK;
end

endmodule
