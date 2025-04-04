module fetch (
    input clk,
    input rst,
    output reg [7:0] pc, // Program Counter
    output wire [15:0] instruction
);

    // Instantiate the instruction memory module
    instruction_memory imem_inst (
        .address(pc),
        .instruction(instruction)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 8'h00; // Reset PC to address 0
        end else begin
            pc <= pc + 1; // Increment PC for the next instruction
        end
    end

endmodule