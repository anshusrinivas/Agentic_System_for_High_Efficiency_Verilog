`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SUB, SEQ, XOR, OR, ROR, DIV, NOR, SGT, MAX, PASSB, SRL, ADD
// Flags: carry, zero, overflow, sign

module ALU_0859W64_75d629fb(
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
    localparam SUB = 4'd0;
    localparam SEQ = 4'd1;
    localparam XOR = 4'd2;
    localparam OR = 4'd3;
    localparam ROR = 4'd4;
    localparam DIV = 4'd5;
    localparam NOR = 4'd6;
    localparam SGT = 4'd7;
    localparam MAX = 4'd8;
    localparam PASSB = 4'd9;
    localparam SRL = 4'd10;
    localparam ADD = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            SEQ: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            OR: begin
                result = input1 | input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 64'b0;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SGT: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            PASSB: begin
                result = input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule