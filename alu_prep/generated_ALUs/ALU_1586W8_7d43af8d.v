`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: OR, NAND, ROR, SGT, DIV, SRA, MIN, MUL, SRL, SLT, SGE, ADD, SLL
// Flags: carry, zero, overflow, sign

module ALU_1586W8_7d43af8d(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam OR = 4'd0;
    localparam NAND = 4'd1;
    localparam ROR = 4'd2;
    localparam SGT = 4'd3;
    localparam DIV = 4'd4;
    localparam SRA = 4'd5;
    localparam MIN = 4'd6;
    localparam MUL = 4'd7;
    localparam SRL = 4'd8;
    localparam SLT = 4'd9;
    localparam SGE = 4'd10;
    localparam ADD = 4'd11;
    localparam SLL = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            OR: begin
                result = input1 | input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SGT: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SLT: begin
            end
            SGE: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule