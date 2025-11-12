`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SRA, ADD, SEQ, OR, ROR, SRL, XOR, NAND, MUL, SLL, SLT, ROL, AND
// Flags: carry, zero, overflow, sign

module ALU_0117W64_5ba1738b(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SRA = 4'd0;
    localparam ADD = 4'd1;
    localparam SEQ = 4'd2;
    localparam OR = 4'd3;
    localparam ROR = 4'd4;
    localparam SRL = 4'd5;
    localparam XOR = 4'd6;
    localparam NAND = 4'd7;
    localparam MUL = 4'd8;
    localparam SLL = 4'd9;
    localparam SLT = 4'd10;
    localparam ROL = 4'd11;
    localparam AND = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            SEQ: begin
            end
            OR: begin
                result = input1 | input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SLT: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            AND: begin
                result = input1 & input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule