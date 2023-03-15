`timescale 1ns / 1ps

module dff0(
   input  clk,
   input  rst_n,
   input  d,
   output reg q
    );
    
always@(posedge clk or negedge rst_n)
  if (!rst_n)
    q <= 0;
  else
    q <= d;
endmodule

module dff1(
   input  clk,
   input  rst_n,
   input  d,
   output reg q
    );
    
always@(posedge clk or negedge rst_n)
  if (!rst_n)
    q <= 1;
  else
    q <= d;
endmodule

module Lab_2(
    input dis,
    input reset,
    input clk,
    output wire [3:0] DEC
    );
    
    wire d0, d1, d2, d3, a0, a1, a2;
    
    xnor  t1(d0, DEC[0], dis);
    dff1 dff1(clk, reset, d0, DEC[0]);
    or o1(a0, dis, DEC[0]);
    
    xnor  t2(d1, DEC[1], a0);
    dff1 dff2(clk, reset, d1, DEC[1]);
    or o2(a1, a0, DEC[0], DEC[1]);
    
    xnor  t3(d2, DEC[2], a1);
    dff1 dff3(clk, reset, d2, DEC[2]);
    or o3(a2, a1, DEC[0], DEC[1], DEC[2]);
    
    xnor  t4(d3, DEC[3], a2);
    dff0 dff4(clk, reset, d3, DEC[3]);
    
endmodule