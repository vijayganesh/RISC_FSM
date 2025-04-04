`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2025 02:16:40 PM
// Design Name: 
// Module Name: alu
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

module alu (
    input [2:0] alu_control,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] result
);

    reg [7:0] temp_result;

    always @(*) begin
        case (alu_control)
            3'b000: temp_result = a + b;       // ADD
            3'b001: temp_result = a - b;       // SUB
            3'b010: temp_result = a & b;       // AND
            3'b011: temp_result = a | b;       // OR
            3'b100: temp_result = ~a;          // NOT (assuming 'b' is ignored)
            default: temp_result = 8'bx;       // Undefined operation
        endcase
        result = temp_result;
    end

endmodule
