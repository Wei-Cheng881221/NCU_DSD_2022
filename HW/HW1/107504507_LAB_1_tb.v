`timescale 1ns / 1ps

module LAB_1_tb;
    // Inputs
    reg A;
    reg B;
    reg C;
    reg S0;
    reg S1;
    // Outputs
    wire D;
    // Instantiate the Unit Under Test (UUT)

    MUX4x1 uut (
        .A(A), 
        .B(B), 
        .C(C),
        .D(D),
        .S0(S0),
        .S1(S1)
        );
    
initial begin // Initialize Inputs
A=0; B=0; C=0; S0=0; S1=0;
    // Wait 100 ns for global reset to finish
    // Add stimulus here
 A=1; B=0; C=0; S1=0; S0=1;
#100; A=0; B=1; C=0; S1=0; S0=0;
#100; A=1; B=0; C=1; S1=1; S0=1;
#100; A=0; B=0; C=1; S1=0; S0=0;
#100; A=0; B=1; C=0; S1=0; S0=0;
#100; A=1; B=1; C=0; S1=1; S0=1;
#100; A=1; B=1; C=1; S1=1; S0=0;
#100; A=0; B=1; C=1; S1=0; S0=0;
#100; A=0; B=0; C=0; S1=1; S0=0;
#100; A=1; B=1; C=0; S1=0; S0=0;
end

endmodule
