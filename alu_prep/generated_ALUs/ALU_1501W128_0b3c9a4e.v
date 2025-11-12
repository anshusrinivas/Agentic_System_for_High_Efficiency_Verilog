`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: MUL, PASSB, ROR, MAX, ROL, SEQ, OR, SRA, SLTU, ADD
// Flags: carry, zero, overflow, sign

module ALU_1501W128_0b3c9a4e(
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
    localparam MUL = 4'd0;
    localparam PASSB = 4'd1;
    localparam ROR = 4'd2;
    localparam MAX = 4'd3;
    localparam ROL = 4'd4;
    localparam SEQ = 4'd5;
    localparam OR = 4'd6;
    localparam SRA = 4'd7;
    localparam SLTU = 4'd8;
    localparam ADD = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MUL: begin
                result = input1 * input2;
            end
            PASSB: begin
                result = input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SEQ: begin
            end
            OR: begin
                result = input1 | input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
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
        signFlag = result[127];
    end

endmodule