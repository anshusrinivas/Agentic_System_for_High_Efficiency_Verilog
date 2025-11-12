`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: AND, MIN, SUB, SLT, SGT, MUL, SRL, NAND
// Flags: carry, zero, overflow

module ALU_1675W64_39f7b6b5(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam AND = 4'd0;
    localparam MIN = 4'd1;
    localparam SUB = 4'd2;
    localparam SLT = 4'd3;
    localparam SGT = 4'd4;
    localparam MUL = 4'd5;
    localparam SRL = 4'd6;
    localparam NAND = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            AND: begin
                result = input1 & input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            SLT: begin
            end
            SGT: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule