`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: MAX, SGT, SEQ, NAND, SUB, SRA, SGE, MUL, OR, MIN, ROR, SRL, DIV
// Flags: carry, zero, overflow, sign

module ALU_0474W128_4d45914e(
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
    localparam MAX = 4'd0;
    localparam SGT = 4'd1;
    localparam SEQ = 4'd2;
    localparam NAND = 4'd3;
    localparam SUB = 4'd4;
    localparam SRA = 4'd5;
    localparam SGE = 4'd6;
    localparam MUL = 4'd7;
    localparam OR = 4'd8;
    localparam MIN = 4'd9;
    localparam ROR = 4'd10;
    localparam SRL = 4'd11;
    localparam DIV = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SGT: begin
            end
            SEQ: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGE: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            OR: begin
                result = input1 | input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule