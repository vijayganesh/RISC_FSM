`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2025 03:43:41 PM
// Design Name: 
// Module Name: fetch_tb
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


module fetch_tb;

    reg clk_tb, rst_tb;
    wire [7:0] pc_tb;
    wire [15:0] instruction_tb;

    // Instantiate the instruction memory module within the testbench
    instruction_memory imem_tb (
        .address(pc_tb),
        .instruction(instruction_tb)
    );

    // Instantiate the fetch module
    fetch uut (
        .clk(clk_tb),
        .rst(rst_tb),
        .pc(pc_tb),
        .instruction(instruction_tb)
    );

    initial begin
        clk_tb = 0;
        rst_tb = 1;

        $monitor("Time=%0t, Reset=%b, PC=%h, Instruction=%h", $time, rst_tb, pc_tb, instruction_tb);

        #10;
        rst_tb = 0;
        #10; // First clock cycle after reset, PC should be 0
        if (pc_tb == 8'h00 && instruction_tb == 16'h0000) $display("PASS: Reset and first fetch OK (PC=0, Inst=0x0000)"); else $display("FAIL: Reset or first fetch failed");

        #10 clk_tb = ~clk_tb; // Clock cycle 1
        #10;
        if (pc_tb == 8'h01 && instruction_tb == 16'h0000) $display("PASS: Second fetch (PC=1, Inst=0x0000) OK"); else $display("FAIL: Second fetch failed (PC=1)");

        #10 clk_tb = ~clk_tb; // Clock cycle 2
        #10;
        if (pc_tb == 8'h01 && instruction_tb == 16'h0400) $display("PASS: Third fetch (PC=1, Inst=0x0400) OK"); else $display("FAIL: Third fetch failed (Inst=0x0400)");

        #10 clk_tb = ~clk_tb; // Clock cycle 3
        #10;
        if (pc_tb == 8'h02 && instruction_tb == 16'h0400) $display("PASS: Fourth fetch (PC=2, Inst=0x0400) OK"); else $display("FAIL: Fourth fetch failed (PC=2)");

        #10 clk_tb = ~clk_tb; // Clock cycle 4
        #10;
        if (pc_tb == 8'h02 && instruction_tb == 16'h0800) $display("PASS: Fifth fetch (PC=2, Inst=0x0800) OK"); else $display("FAIL: Fifth fetch failed (Inst=0x0800)");

        #50;
        $finish;
    end

    always #5 clk_tb = ~clk_tb; // 10ns clock period

endmodule
