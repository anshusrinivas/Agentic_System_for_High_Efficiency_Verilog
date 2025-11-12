`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRA, MAX, XOR, SGT, SLL, AND, SUB, OR, DIV, SEQ, ROL, SGE, XNOR, ADD
// Flags: carry, zero, overflow

module ALU_0296W16_10e83440(
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
    localparam SRA = 4'd0;
    localparam MAX = 4'd1;
    localparam XOR = 4'd2;
    localparam SGT = 4'd3;
    localparam SLL = 4'd4;
    localparam AND = 4'd5;
    localparam SUB = 4'd6;
    localparam OR = 4'd7;
    localparam DIV = 4'd8;
    localparam SEQ = 4'd9;
    localparam ROL = 4'd10;
    localparam SGE = 4'd11;
    localparam XNOR = 4'd12;
    localparam ADD = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SGT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            AND: begin
                result = input1 & input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            OR: begin
                result = input1 | input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SEQ: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SGE: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule