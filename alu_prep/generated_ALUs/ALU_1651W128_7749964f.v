`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: MUL, ADD, DIV, NOR, SRA, OR, SLL, SUB, MIN, XNOR, SGT, AND
// Flags: carry, zero, overflow

module ALU_1651W128_7749964f(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam MUL = 4'd0;
    localparam ADD = 4'd1;
    localparam DIV = 4'd2;
    localparam NOR = 4'd3;
    localparam SRA = 4'd4;
    localparam OR = 4'd5;
    localparam SLL = 4'd6;
    localparam SUB = 4'd7;
    localparam MIN = 4'd8;
    localparam XNOR = 4'd9;
    localparam SGT = 4'd10;
    localparam AND = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SGT: begin
            end
            AND: begin
                result = input1 & input2;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule