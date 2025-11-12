`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: ROR, MAX, XOR, NAND, MUL, OR, AND, SUB, SRL, SGE, ADD, SLTU
// Flags: carry, zero, overflow, sign

module ALU_1374W16_1e4162b1(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ROR = 4'd0;
    localparam MAX = 4'd1;
    localparam XOR = 4'd2;
    localparam NAND = 4'd3;
    localparam MUL = 4'd4;
    localparam OR = 4'd5;
    localparam AND = 4'd6;
    localparam SUB = 4'd7;
    localparam SRL = 4'd8;
    localparam SGE = 4'd9;
    localparam ADD = 4'd10;
    localparam SLTU = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROR: begin
                result = ror(input1, shiftValue);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
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
            OR: begin
                result = input1 | input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGE: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            SLTU: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule