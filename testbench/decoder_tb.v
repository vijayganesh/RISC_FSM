`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2025 03:58:19 PM
// Design Name: 
// Module Name: decoder_tb
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


`timescale 1ns/1ps

module tb_decoder;

    reg [15:0] instruction_tb;
    wire [2:0] alu_op_tb;
    wire reg_write_enable_tb;
    wire [2:0] dest_reg_tb;
    wire [2:0] src_reg1_tb;
    wire [2:0] src_reg2_tb;
    wire load_immediate_tb;
    wire [7:0] immediate_data_tb;

    decoder uut (
        .instruction(instruction_tb),
        .alu_op(alu_op_tb),
        .reg_write_enable(reg_write_enable_tb),
        .dest_reg_sel(dest_reg_tb),
        .src_reg1_sel(src_reg1_tb),
        .src_reg2_sel(src_reg2_tb),
        .load_immediate(load_immediate_tb),
        .immediate_data(immediate_data_tb)
    );

    initial begin
        $monitor("Time=%0t, Instruction=%b, ALU_Op=%b, Reg_WE=%b, Dest_Reg=%b, Src1_Reg=%b, Src2_Reg=%b, Load_Imm=%b, Imm_Data=%h",
                 $time, instruction_tb, alu_op_tb, reg_write_enable_tb, dest_reg_tb, src_reg1_tb, src_reg2_tb, load_immediate_tb, immediate_data_tb);

        // Test ADD instruction
        instruction_tb = 16'b000_101_010_001_1000; // ADD Reg[5], Reg[2], Reg[3]
        #10;
        if (alu_op_tb == 3'b000 && reg_write_enable_tb == 1'b1 &&
            dest_reg_tb == 3'b101 && src_reg1_tb == 3'b010 && src_reg2_tb == 3'b001 &&
            load_immediate_tb == 1'b0 && immediate_data_tb == 8'h00) begin
            $display("PASS: ADD instruction OK");
        end else begin
            $display("FAIL: ADD instruction failed");
        end

        // Test SUB instruction
        instruction_tb = 16'b001_011_001_010_0000; // SUB Reg[5], Reg[1], Reg[2]
        #10;
        if (alu_op_tb == 3'b001 && reg_write_enable_tb == 1'b1 &&
            dest_reg_tb == 3'b110 && src_reg1_tb == 3'b011 && src_reg2_tb == 3'b010 &&
            load_immediate_tb == 1'b0 && immediate_data_tb == 8'h00) begin
            $display("PASS: SUB instruction OK");
        end else begin
            $display("FAIL: SUB instruction failed");
        end

        // Test AND instruction
        instruction_tb = 16'b010_001_000_101_0000; // AND Reg[1], Reg[0], Reg[2]
        #10;
        if (alu_op_tb == 3'b010 && reg_write_enable_tb == 1'b1 &&
            dest_reg_tb == 3'b001 && src_reg1_tb == 3'b000 && src_reg2_tb == 3'b101 &&
            load_immediate_tb == 1'b0 && immediate_data_tb == 8'h00) begin
            $display("PASS: AND instruction OK");
        end else begin
            $display("FAIL: AND instruction failed");
        end

        // Test OR instruction
        instruction_tb = 16'b011_010_011_000_0000; // OR Reg[2], Reg[3], Reg[0]
        #10;
        if (alu_op_tb == 3'b011 && reg_write_enable_tb == 1'b1 &&
            dest_reg_tb == 3'b010 && src_reg1_tb == 3'b011 && src_reg2_tb == 3'b000 &&
            load_immediate_tb == 1'b0 && immediate_data_tb == 8'h00) begin
            $display("PASS: OR instruction OK");
        end else begin
            $display("FAIL: OR instruction failed");
        end

        // Test NOT instruction
        instruction_tb = 16'b1000010010000000; // NOT Reg[1], Reg[2]
        #10;
        if (alu_op_tb == 3'b100 && reg_write_enable_tb == 1'b1 &&
            dest_reg_tb == 3'b001 && src_reg1_tb == 3'b010 && src_reg2_tb == 3'b000 &&
            load_immediate_tb == 1'b0 && immediate_data_tb == 8'h00) begin
            $display("PASS: NOT instruction OK");
        end else begin
            $display("FAIL: NOT instruction failed");
        end

        // Test LOAD IMMEDIATE instruction
        instruction_tb = 16'b1011110001111111; // LOAD IMMEDIATE Reg[7], 127 (0x7F)
        #10;
        if (alu_op_tb == 3'bxxx && reg_write_enable_tb == 1'b1 &&
            dest_reg_tb == 3'b111 && src_reg1_tb == 3'bxxx && src_reg2_tb == 3'bxxx &&
            load_immediate_tb == 1'b1 && immediate_data_tb == 8'h7F) begin
            $display("PASS: LOAD IMMEDIATE instruction OK");
        end else begin
            $display("FAIL: LOAD IMMEDIATE instruction failed");
        end

        // Test default case
        instruction_tb = 16'b1100000000000000; // Invalid Opcode
        #10;
        if(alu_op_tb == 3'bxxx && reg_write_enable_tb == 1'b0 && dest_reg_tb == 3'bxxx &&
            src_reg1_tb == 3'bxxx && src_reg2_tb == 3'bxxx && load_immediate_tb == 1'b0 &&
            immediate_data_tb == 8'h00) begin
            $display("PASS: Default case OK");
        end else begin
            $display("FAIL: Default case failed");
        end

        #50;
        $finish;
    end

endmodule

