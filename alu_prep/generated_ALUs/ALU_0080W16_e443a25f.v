`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRL, ROR, NAND, MAX, SUB, SGE, PASSB, SNE, SLL, OR, AND, MUL
// Flags: carry, zero, overflow

module ALU_0080W16_e443a25f(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SRL = 4'd0;
    localparam ROR = 4'd1;
    localparam NAND = 4'd2;
    localparam MAX = 4'd3;
    localparam SUB = 4'd4;
    localparam SGE = 4'd5;
    localparam PASSB = 4'd6;
    localparam SNE = 4'd7;
    localparam SLL = 4'd8;
    localparam OR = 4'd9;
    localparam AND = 4'd10;
    localparam MUL = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            SGE: begin
            end
            PASSB: begin
                result = input2;
            end
            SNE: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            AND: begin
                result = input1 & input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule