`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SRA, SEQ, SLL, MUL, ROL, ADD, SNE, SGT, XOR, NAND
// Flags: carry

module ALU_1017W8_8351f0d2(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SRA = 4'd0;
    localparam SEQ = 4'd1;
    localparam SLL = 4'd2;
    localparam MUL = 4'd3;
    localparam ROL = 4'd4;
    localparam ADD = 4'd5;
    localparam SNE = 4'd6;
    localparam SGT = 4'd7;
    localparam XOR = 4'd8;
    localparam NAND = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SEQ: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            MUL: begin
                result = input1 * input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SNE: begin
            end
            SGT: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            default: result = 8'b0;
        endcase
    end

endmodule