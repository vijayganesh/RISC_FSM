`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2025 11:25:46 AM
// Design Name: 
// Module Name: top_test2
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


module top_test2(

    );
    


    reg clk_tb, rst_tb;
    wire [15:0] current_instruction_tb;
    wire [7:0] program_counter_out_tb;

    // Instantiate the top-level module
    top_level uut (
        .clk(clk_tb),
        .rst(rst_tb),
        .current_instruction(current_instruction_tb),
        .program_counter_out(program_counter_out_tb)
    );

    // Clock generation
    always #5 clk_tb = ~clk_tb;

    initial begin
        // Initialize signals
        clk_tb = 0;
        rst_tb = 1;

        // Display header
        $display("Time  Reset PC    Instr       Reg[0]  Reg[1]  ALU_Result  ALU_Op  RegWr   DestReg Src1Reg Src2Reg Imm     LoadImm");
$monitor("%0t %-4b %-4h %-4h %-4h %-4h %-10h %-8b %-8b %-8b %-8b %-8b %-8h %-8b",
                  $time, rst_tb, program_counter_out_tb, current_instruction_tb,
                  uut.reg_file_inst.registers[0],
                  uut.reg_file_inst.registers[1],
                  uut.alu_inst.result,
                  uut.decoder_inst.alu_op,
                  uut.decoder_inst.reg_write_enable,
                  uut.decoder_inst.dest_reg_sel,
                  uut.decoder_inst.src_reg1_sel,
                  uut.decoder_inst.src_reg2_sel,
                  uut.decoder_inst.immediate_data,
                  uut.decoder_inst.load_immediate
                 );

        // Reset sequence
        #10;
        rst_tb = 0;
        #10;

        // Simulate instructions and check results
        //After first two LOAD IMMEDIATE instructions Reg[0] = 170, Reg[1] = 12
        #10; // ADD Reg0, Reg0, Reg1  ; Reg0 = 170 + 12 = 182
        if (uut.reg_file_inst.registers[0] == 8'hB6) $display("PASS: ADD OK"); else $display("FAIL: ADD");
        if (uut.decoder_inst.alu_op != 3'b000 || uut.decoder_inst.reg_write_enable != 1'b1 || uut.decoder_inst.dest_reg_sel != 3'b000 || uut.decoder_inst.src_reg1_sel != 3'b000 || uut.decoder_inst.src_reg2_sel != 3'b001) $display("FAIL: Decoder ADD");

        #10; // SUB Reg0, Reg0, Reg1  ; Reg0 = 182 - 12 = 170
        if (uut.reg_file_inst.registers[0] == 8'hAA) $display("PASS: SUB OK"); else $display("FAIL: SUB");
        if (uut.decoder_inst.alu_op != 3'b001 || uut.decoder_inst.reg_write_enable != 1'b1 || uut.decoder_inst.dest_reg_sel != 3'b000 || uut.decoder_inst.src_reg1_sel != 3'b000 || uut.decoder_inst.src_reg2_sel != 3'b001) $display("FAIL: Decoder SUB");

        #10; // AND Reg0, Reg0, Reg1  ; Reg0 = 170 & 12 = 8
        if (uut.reg_file_inst.registers[0] == 8'h08) $display("PASS: AND OK"); else $display("FAIL: AND");
        if (uut.decoder_inst.alu_op != 3'b010 || uut.decoder_inst.reg_write_enable != 1'b1 || uut.decoder_inst.dest_reg_sel != 3'b000 || uut.decoder_inst.src_reg1_sel != 3'b000 || uut.decoder_inst.src_reg2_sel != 3'b001) $display("FAIL: Decoder AND");

        #10; // OR Reg0, Reg0, Reg1    ; Reg0 = 8 | 12 = 12
        if (uut.reg_file_inst.registers[0] == 8'h0C) $display("PASS: OR OK"); else $display("FAIL: OR");
        if (uut.decoder_inst.alu_op != 3'b011 || uut.decoder_inst.reg_write_enable != 1'b1 || uut.decoder_inst.dest_reg_sel != 3'b000 || uut.decoder_inst.src_reg1_sel != 3'b000 || uut.decoder_inst.src_reg2_sel != 3'b001) $display("FAIL: Decoder OR");

        #10; // NOT Reg0, Reg0        ; Reg0 = ~12 = 243
        if (uut.reg_file_inst.registers[0] == 8'hF3) $display("PASS: NOT OK"); else $display("FAIL: NOT");
        if (uut.decoder_inst.alu_op != 3'b100 || uut.decoder_inst.reg_write_enable != 1'b1 || uut.decoder_inst.dest_reg_sel != 3'b000 || uut.decoder_inst.src_reg1_sel != 3'b000 || uut.decoder_inst.src_reg2_sel != 3'b000) $display("FAIL: Decoder NOT");

        #50;
        $finish;
    end

endmodule
