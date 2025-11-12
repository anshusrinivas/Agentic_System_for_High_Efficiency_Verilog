`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SGT, SLL, OR, ADD, MAX, SLTU, SRL, NAND, SNE, SUB, MIN, MUL
// Flags: carry, zero, overflow, sign

module ALU_0836W64_4d1c6fdc(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SGT = 4'd0;
    localparam SLL = 4'd1;
    localparam OR = 4'd2;
    localparam ADD = 4'd3;
    localparam MAX = 4'd4;
    localparam SLTU = 4'd5;
    localparam SRL = 4'd6;
    localparam NAND = 4'd7;
    localparam SNE = 4'd8;
    localparam SUB = 4'd9;
    localparam MIN = 4'd10;
    localparam MUL = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SLTU: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SNE: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule