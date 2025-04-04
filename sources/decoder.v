`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2025 03:57:22 PM
// Design Name: 
// Module Name: decoder
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


module decoder (
    input [15:0] instruction,
    output reg [2:0] alu_op,
    output reg reg_write_enable,
    output reg [2:0] dest_reg_sel,
    output reg [2:0] src_reg1_sel,
    output reg [2:0] src_reg2_sel,
    output reg load_immediate,
    output reg [7:0] immediate_data
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
    localparam IMM_DATA_START = 8;
    localparam REG_FIELD_WIDTH = 3;
    localparam IMM_DATA_WIDTH = 8;

    always @(*) begin
        alu_op = 3'bxxx;
        reg_write_enable = 1'b0;
        dest_reg_sel = 3'bxxx;
        src_reg1_sel = 3'bxxx;
        src_reg2_sel = 3'bxxx;
        load_immediate = 1'b0;
        immediate_data = 8'h00;

        case (instruction[15:13])
            ADD_OPCODE: begin
                alu_op = 3'b000;
                reg_write_enable = 1'b1;
                dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                src_reg2_sel = instruction[SRC2_REG_START:SRC2_REG_START-REG_FIELD_WIDTH+1];
            end
            SUB_OPCODE: begin
                alu_op = 3'b001;
                reg_write_enable = 1'b1;
                dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                src_reg2_sel = instruction[SRC2_REG_START:SRC2_REG_START-REG_FIELD_WIDTH+1];
            end
            AND_OPCODE: begin
                alu_op = 3'b010;
                reg_write_enable = 1'b1;
                dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                src_reg2_sel = instruction[SRC2_REG_START:SRC2_REG_START-REG_FIELD_WIDTH+1];
            end
            OR_OPCODE: begin
                alu_op = 3'b011;
                reg_write_enable = 1'b1;
                dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                src_reg2_sel = instruction[SRC2_REG_START:SRC2_REG_START-REG_FIELD_WIDTH+1];
            end
            NOT_OPCODE: begin
                alu_op = 3'b100;
                reg_write_enable = 1'b1;
                dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                src_reg1_sel = instruction[SRC1_REG_START:SRC1_REG_START-REG_FIELD_WIDTH+1];
                src_reg2_sel = 3'b000; // Unused
            end
            LOAD_IMM_OPCODE: begin
                load_immediate = 1'b1;
                reg_write_enable = 1'b1;
                dest_reg_sel = instruction[DEST_REG_START:DEST_REG_START-REG_FIELD_WIDTH+1];
                immediate_data = instruction[IMM_DATA_START-1:IMM_DATA_START-IMM_DATA_WIDTH];
            end
            default: begin
                // No change to defaults
            end
        endcase
    end

endmodule

