`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SNE, XOR, AND, SGT, SRA, ADD, OR, SLL, XNOR, SRL, MAX, MIN, ROR
// Flags: carry, zero, overflow, sign

module ALU_1420W128_761c9655(
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
    localparam XOR = 4'd1;
    localparam AND = 4'd2;
    localparam SGT = 4'd3;
    localparam SRA = 4'd4;
    localparam ADD = 4'd5;
    localparam OR = 4'd6;
    localparam SLL = 4'd7;
    localparam XNOR = 4'd8;
    localparam SRL = 4'd9;
    localparam MAX = 4'd10;
    localparam MIN = 4'd11;
    localparam ROR = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SNE: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SGT: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            OR: begin
                result = input1 | input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule