`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SLT, NAND, SLL, XOR, SRL, OR, SUB, NOR, SLTU, ADD
// Flags: carry, zero, overflow

module ALU_0141W128_d1f3254d(
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
    localparam SLT = 4'd0;
    localparam NAND = 4'd1;
    localparam SLL = 4'd2;
    localparam XOR = 4'd3;
    localparam SRL = 4'd4;
    localparam OR = 4'd5;
    localparam SUB = 4'd6;
    localparam NOR = 4'd7;
    localparam SLTU = 4'd8;
    localparam ADD = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLTU: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule