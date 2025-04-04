`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2025 10:40:34 AM
// Design Name: 
// Module Name: resiter_tb
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


module register_file_tb;

  reg clk;
  reg we;
  reg [2:0] rd_addr1, rd_addr2, wr_addr;
  reg [7:0] wr_data_alu, wr_data_imm;
  reg reg_write_data_select;
  wire [7:0] rd_data1, rd_data2;

  // Instantiate the register file
  register_file rf(
      .clk(clk),
      .we(we),
      .rd_addr1(rd_addr1),
      .rd_addr2(rd_addr2),
      .wr_addr(wr_addr),
      .wr_data_alu(wr_data_alu),
      .wr_data_imm(wr_data_imm),
      .reg_write_data_select(reg_write_data_select),
      .rd_data1(rd_data1),
      .rd_data2(rd_data2)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize signals
    clk = 0;
    we = 0;
    rd_addr1 = 0;
    rd_addr2 = 0;
    wr_addr = 0;
    wr_data_alu = 8'h00;
    wr_data_imm = 8'h00;
    reg_write_data_select = 0;

    // Display initial state
    $display("Time\tWE\tWrAddr\tWrDataALU\tWrDataIMM\tRegWrSel\tRD1Addr\tRD1Data\tRD2Addr\tRD2Data");
    $monitor("%0t\t%b\t%d\t%h\t%h\t%b\t%d\t%h\t%d\t%h",
             $time, we, wr_addr, wr_data_alu, wr_data_imm, reg_write_data_select,
             rd_addr1, rd_data1, rd_addr2, rd_data2);

    // Reset
    #10;

    // Test write with ALU data
    we = 1;
    wr_addr = 3'b001;
    wr_data_alu = 8'h55;
    reg_write_data_select = 0;
    #10;
    if (rf.registers[1] == 8'h55) $display("PASS: Write ALU data");
    else $display("FAIL: Write ALU data");

    // Test write with immediate data
    wr_addr = 3'b010;
    wr_data_imm = 8'hAA;
    reg_write_data_select = 1;
    #10;
     if (rf.registers[2] == 8'hAA) $display("PASS: Write IMM data");
    else $display("FAIL: Write IMM data");

    // Test read
    we = 0;
    rd_addr1 = 3'b001;
    rd_addr2 = 3'b010;
    #10;
    if (rd_data1 == 8'h55 && rd_data2 == 8'hAA) $display("PASS: Read data");
    else $display("FAIL: Read data");

    // Test write to register 0
    we = 1;
    wr_addr = 3'b000;
    wr_data_alu = 8'hFF;
    reg_write_data_select = 0;
    #10;
    if (rf.registers[0] == 8'hFF) $display("PASS: Write Reg 0 data");
    else $display("FAIL: Write Reg 0 data");

    // Finish
    #10;
    $finish;
  end

endmodule
