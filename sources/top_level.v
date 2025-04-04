`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2025 10:06:47 AM
// Design Name: 
// Module Name: top_level
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


module top_level (
    input clk,
    input rst,
    output wire [15:0] current_instruction,
    output wire [7:0] program_counter_out,
    output wire [7:0] results
);

    wire [7:0] program_counter;
    wire [2:0] alu_control_wire;
    wire reg_write_en_wire;
    wire [2:0] dest_reg_sel_wire;
    wire [2:0] src_reg1_sel_wire;
    wire [2:0] src_reg2_sel_wire;
    wire reg_write_data_sel_wire;
    wire [7:0] reg_immediate_data_wire;
    wire alu_en_wire;
    wire [7:0] alu_result_wire;
    wire [7:0] rd_data1_wire;
    wire [7:0] rd_data2_wire;

    fetch fetch_unit (
        .clk(clk),
        .rst(rst),
        .pc(program_counter),
        .instruction(current_instruction)
    );

    control_unit control_unit_inst (
        .clk(clk),
        .rst(rst),
        .instruction(current_instruction),
        .alu_en(alu_en_wire),
        .reg_write_en(reg_write_en_wire),
        .alu_control(alu_control_wire),
        .dest_reg_sel(dest_reg_sel_wire),
        .src_reg1_sel(src_reg1_sel_wire),
        .src_reg2_sel(src_reg2_sel_wire),
        .reg_write_data_sel(reg_write_data_sel_wire)
    );

    decoder decoder_inst (
        .instruction(current_instruction),
        .alu_op(alu_control_wire),
        .reg_write_enable(reg_write_en_wire),
        .dest_reg_sel(dest_reg_sel_wire),
        .src_reg1_sel(src_reg1_sel_wire),
        .src_reg2_sel(src_reg2_sel_wire),
        .load_immediate(reg_write_data_sel_wire),
        .immediate_data(reg_immediate_data_wire)
    );

    alu alu_inst (
        .alu_control(alu_control_wire),
        .a(rd_data1_wire),
        .b(rd_data2_wire),
        .result(alu_result_wire)
    );


    register_file reg_file_inst (
        .clk(clk),
        .we(reg_write_en_wire),
        .rd_addr1(src_reg1_sel_wire),
        .rd_addr2(src_reg2_sel_wire),
        .wr_addr(dest_reg_sel_wire),
        .wr_data_alu(alu_result_wire),
        .wr_data_imm(reg_immediate_data_wire),
        .reg_write_data_select(reg_write_data_sel_wire),
        .rd_data1(rd_data1_wire),
        .rd_data2(rd_data2_wire)
    );

    assign program_counter_out = program_counter;
    assign results = alu_result_wire;

endmodule