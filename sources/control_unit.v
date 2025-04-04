`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2025 10:00:14 AM
// Design Name: 
// Module Name: control_unit
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

module control_unit (
    input clk,
    input rst,
    input [15:0] instruction,
    output reg alu_en,
    output reg reg_write_en,
    output reg [2:0] alu_control,
    output reg [2:0] dest_reg_sel,
    output reg [2:0] src_reg1_sel,
    output reg [2:0] src_reg2_sel,
    output reg reg_write_data_sel // Select ALU result or immediate data
);

    // Opcode field (bits 15:13)
    localparam ADD_OPCODE = 3'b000;
    localparam SUB_OPCODE = 3'b001;
    localparam AND_OPCODE = 3'b010;
    localparam OR_OPCODE  = 3'b011;
    localparam NOT_OPCODE = 3'b100;
    localparam LOAD_IMM_OPCODE = 3'b101;

    // Register field locations
    localparam DEST_REG_START = 12;
    localparam SRC1_REG_START = 9;
    localparam SRC2_REG_START = 6;
    localparam REG_FIELD_WIDTH = 3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            alu_en = 1'b0;
            reg_write_en = 1'b0;
            alu_control = 3'b000;
            dest_reg_sel = 3'b000;
            src_reg1_sel = 3'b000;
            src_reg2_sel = 3'b000;
            reg_write_data_sel = 1'b0;
        end else begin
            case (instruction[15:13])
                ADD_OPCODE: begin
                    alu_en = 1'b1;
                    reg_write_en = 1'b1;
                    alu_control = 3'b000; // ADD operation
                    dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                    src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                    src_reg2_sel = instruction[SRC2_REG_START:SRC2_REG_START-REG_FIELD_WIDTH+1];
                    reg_write_data_sel = 1'b0; // Select ALU result
                end
                SUB_OPCODE: begin
                    alu_en = 1'b1;
                    reg_write_en = 1'b1;
                    alu_control = 3'b001; // SUB operation
                    dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                    src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                    src_reg2_sel = instruction[SRC2_REG_START:SRC2_REG_START-REG_FIELD_WIDTH+1];
                    reg_write_data_sel = 1'b0; // Select ALU result
                end
                AND_OPCODE: begin
                    alu_en = 1'b1;
                    reg_write_en = 1'b1;
                    alu_control = 3'b010; // AND operation
                    dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                    src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                    src_reg2_sel = instruction[SRC2_REG_START:SRC2_REG_START-REG_FIELD_WIDTH+1];
                    reg_write_data_sel = 1'b0; // Select ALU result
                end
                OR_OPCODE: begin
                    alu_en = 1'b1;
                    reg_write_en = 1'b1;
                    alu_control = 3'b011; // OR operation
                    dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                    src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                    src_reg2_sel = instruction[SRC2_REG_START:SRC2_REG_START-REG_FIELD_WIDTH+1];
                    reg_write_data_sel = 1'b0; // Select ALU result
                end
                NOT_OPCODE: begin
                    alu_en = 1'b1;
                    reg_write_en = 1'b1;
                    alu_control = 3'b100; // NOT operation
                    dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                    src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                    src_reg2_sel = 3'b000; // Not used
                    reg_write_data_sel = 1'b0; // Select ALU result
                end
                LOAD_IMM_OPCODE: begin
                    alu_en = 1'b0; // ALU not used
                    reg_write_en = 1'b1;
                    alu_control = 3'b000; // Not used
                    dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                    src_reg1_sel = 3'b000; // Not used
                    src_reg2_sel = 3'b000; // Not used
                    reg_write_data_sel = 1'b1; // Select immediate data
                end
                default: begin
                    alu_en = 1'b0;
                    reg_write_en = 1'b0;
                    alu_control = 3'b000;
                    dest_reg_sel = 3'b000;
                    src_reg1_sel = 3'b000;
                    src_reg2_sel = 3'b000;
                    reg_write_data_sel = 1'b0;
                end
            endcase
        end
    end

endmodule