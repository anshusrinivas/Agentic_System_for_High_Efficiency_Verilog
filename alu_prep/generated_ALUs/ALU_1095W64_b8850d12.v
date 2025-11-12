`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: OR, MUL, SGE, MIN, SRA, ADD, SLL, SLTU, SEQ, SRL, NOR, SLT
// Flags: carry, zero, overflow

module ALU_1095W64_b8850d12(
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
    localparam OR = 4'd0;
    localparam MUL = 4'd1;
    localparam SGE = 4'd2;
    localparam MIN = 4'd3;
    localparam SRA = 4'd4;
    localparam ADD = 4'd5;
    localparam SLL = 4'd6;
    localparam SLTU = 4'd7;
    localparam SEQ = 4'd8;
    localparam SRL = 4'd9;
    localparam NOR = 4'd10;
    localparam SLT = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            OR: begin
                result = input1 | input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            SGE: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SLTU: begin
            end
            SEQ: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLT: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule