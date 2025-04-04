`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2025 10:04:08 AM
// Design Name: 
// Module Name: Register
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

module register_file (
    input clk,
    input we, // Write enable
    input [2:0] rd_addr1,
    input [2:0] rd_addr2,
    input [2:0] wr_addr,
    input [7:0] wr_data_alu, // Data from ALU
    input [7:0] wr_data_imm, // Data from immediate
    input reg_write_data_select, // Select ALU or Immediate
    output [7:0] rd_data1,
    output [7:0] rd_data2
     // Changed to output reg
);

reg [7:0] registers [0:7];

    // Read ports
    assign rd_data1 = registers[rd_addr1];
    assign rd_data2 = registers[rd_addr2];

    // Write port
    always @(posedge clk) begin
        if (we) begin
            if (reg_write_data_select) begin
                registers[wr_addr] <= wr_data_imm; // Write immediate data
            end else begin
                registers[wr_addr] <= wr_data_alu; // Write ALU result
            end
        end
    end



endmodule
