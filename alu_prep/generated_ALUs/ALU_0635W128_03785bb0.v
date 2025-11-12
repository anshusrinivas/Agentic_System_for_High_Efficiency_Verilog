`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SNE, MUL, SEQ, PASSB, NAND, SUB, ROR, SGT, SLT, SRA, OR
// Flags: carry, zero, overflow, sign

module ALU_0635W128_03785bb0(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SNE = 4'd0;
    localparam MUL = 4'd1;
    localparam SEQ = 4'd2;
    localparam PASSB = 4'd3;
    localparam NAND = 4'd4;
    localparam SUB = 4'd5;
    localparam ROR = 4'd6;
    localparam SGT = 4'd7;
    localparam SLT = 4'd8;
    localparam SRA = 4'd9;
    localparam OR = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SNE: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SEQ: begin
            end
            PASSB: begin
                result = input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SGT: begin
            end
            SLT: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule