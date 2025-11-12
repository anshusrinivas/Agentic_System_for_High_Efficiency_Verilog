`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: AND, SLL, PASSB, XOR, ROR, SRA, DIV, ADD, SUB, SNE, OR, SLTU, SGT, MIN
// Flags: carry, zero, overflow, sign

module ALU_1486W128_06d663d5(
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
    localparam AND = 4'd0;
    localparam SLL = 4'd1;
    localparam PASSB = 4'd2;
    localparam XOR = 4'd3;
    localparam ROR = 4'd4;
    localparam SRA = 4'd5;
    localparam DIV = 4'd6;
    localparam ADD = 4'd7;
    localparam SUB = 4'd8;
    localparam SNE = 4'd9;
    localparam OR = 4'd10;
    localparam SLTU = 4'd11;
    localparam SGT = 4'd12;
    localparam MIN = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            AND: begin
                result = input1 & input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            SNE: begin
            end
            OR: begin
                result = input1 | input2;
            end
            SLTU: begin
            end
            SGT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule