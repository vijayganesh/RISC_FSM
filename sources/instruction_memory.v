`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2025 03:52:08 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory (
    input [7:0] address,
    output reg [15:0] instruction
);

    reg [15:0] mem [0:255]; // 256 locations, 16 bits wide

    // Initial block to load instructions (for simulation)
    initial begin
        // Example instructions - replace with your actual program
          mem[0] = 16'b1010000001010101; // LOAD IMMEDIATE Reg0, 0xAA (170)
        mem[1] = 16'b1010010000001100; // LOAD IMMEDIATE Reg1, 0x0C (12)
        mem[2] = 16'b0000000000001000; // ADD Reg0, Reg0, Reg1 ; R0 = R0 + R1
        mem[3] = 16'b0010000000001000; // SUB Reg0, Reg0, Reg1; R0 = R0 - R1
        mem[4] = 16'b0100000000001000; // AND Reg0, Reg0, Reg1;
        mem[5] = 16'b0110000000001000; // OR Reg0, Reg0, Reg1
        mem[6] = 16'b1000000000000000; // NOT Reg0, Reg0
        mem[7] = 16'b0000000000000000;
        mem[8] = 16'b0000000000000000;
        mem[9] = 16'b0000000000000000;
        mem[10] = 16'b0000000000000000;
        mem[11] = 16'b0000000000000000;
        // ... add more instructions ...
    end

    always @(address) begin
        instruction <= mem[address];
    end

endmodule