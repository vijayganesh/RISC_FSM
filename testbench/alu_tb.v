`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2025 02:18:01 PM
// Design Name: 
// Module Name: alu_tb
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

module alu_tb;

    reg [2:0] alu_control_tb;
    reg [7:0] a_tb, b_tb;
    wire [7:0] result_tb;

    alu uut (
        .alu_control(alu_control_tb),
        .a(a_tb),
        .b(b_tb),
        .result(result_tb)
    );

    initial begin
        // Initialize inputs
        a_tb = 8'h0A;
        b_tb = 8'h05;
        alu_control_tb = 3'bxxx;

        $monitor("Time=%0t, ALU Control=%b, A=%h, B=%h, Result=%h", $time, alu_control_tb, a_tb, b_tb, result_tb);

        // Test ADD
        alu_control_tb = 3'b000;
        #10;
        if (result_tb == (a_tb + b_tb)) $display("PASS: ADD test passed"); else $display("FAIL: ADD test failed");

        // Test SUB
        alu_control_tb = 3'b001;
        #10;
        if (result_tb == (a_tb - b_tb)) $display("PASS: SUB test passed"); else $display("FAIL: SUB test failed");

        // Test AND
        alu_control_tb = 3'b010;
        #10;
        if (result_tb == (a_tb & b_tb)) $display("PASS: AND test passed"); else $display("FAIL: AND test failed");

        // Test OR
        alu_control_tb = 3'b011;
        #10;
        if (result_tb == (a_tb | b_tb)) $display("PASS: OR test passed"); else $display("FAIL: OR test failed");

        // Test NOT
        alu_control_tb = 3'b100;
        a_tb = 8'hF0; // Test with a different value for NOT
        #10;
        if (result_tb == (~a_tb)) $display("PASS: NOT test passed"); else $display("FAIL: NOT test failed");

        // Test undefined operation
        alu_control_tb = 3'b101;
        #10;
        $display("INFO: Testing undefined ALU operation, result should be 'x'");

        $finish;
    end

endmodule

