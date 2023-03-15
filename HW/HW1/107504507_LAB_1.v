`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/03 10:33:23
// Design Name: 
// Module Name: LAB_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Even_ones(A,B,C,D);
input A,B,C;
output D;
assign D=(A~^B)^C;
endmodule

module OAI(A,B,C,D);
input A,B,C;
output D;
assign D=~((A|B)&C);
endmodule

module Allzero(A,B,C,D);
input A,B,C;
output D;
assign D = ~(A|B|C);
endmodule

module Fun2(A, B, C, D);
input A, B, C;
output D;
assign D = ~((A~^B)&C);
endmodule

module MUX4x1(A,B,C,D, S0, S1);
input A, B, C, S0, S1;
wire D0, D1, D2, D3, T0, T1, T2, T3, S0BAR, S1BAR;
output D;

Even_ones mod0(.A(A), .B(B), .C(C), .D(D0));
OAI mod1(A, B, C, D1);
Allzero mod2(A,B,C,D2);
Fun2 mod3(A, B, C, D3);

not (S0BAR, S0), (S1BAR, S1);

and (T0, D0, S0BAR, S1BAR),
    (T1, D1, S0, S1BAR),
    (T2, D2, S0BAR, S1),
    (T3, D3, S0, S1);

or (D, T0, T1, T2, T3);

endmodule










