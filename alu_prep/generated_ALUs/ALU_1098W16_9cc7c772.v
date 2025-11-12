`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: MUL, ADD, SEQ, NOR, SRA, OR, SRL, ROL, MAX, AND
// Flags: carry, zero, overflow, sign

module ALU_1098W16_9cc7c772(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam MUL = 4'd0;
    localparam ADD = 4'd1;
    localparam SEQ = 4'd2;
    localparam NOR = 4'd3;
    localparam SRA = 4'd4;
    localparam OR = 4'd5;
    localparam SRL = 4'd6;
    localparam ROL = 4'd7;
    localparam MAX = 4'd8;
    localparam AND = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            SEQ: begin
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
            SRL: begin
                result = input1 >> shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            AND: begin
                result = input1 & input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule