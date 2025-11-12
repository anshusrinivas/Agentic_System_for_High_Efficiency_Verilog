`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SGT, MIN, AND, NOR, SRA, SEQ, SNE, SLT, SUB
// Flags: carry, zero, overflow

module ALU_1748W64_ab1b5c6d(
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
    localparam SGT = 4'd0;
    localparam MIN = 4'd1;
    localparam AND = 4'd2;
    localparam NOR = 4'd3;
    localparam SRA = 4'd4;
    localparam SEQ = 4'd5;
    localparam SNE = 4'd6;
    localparam SLT = 4'd7;
    localparam SUB = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            AND: begin
                result = input1 & input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SEQ: begin
            end
            SNE: begin
            end
            SLT: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule