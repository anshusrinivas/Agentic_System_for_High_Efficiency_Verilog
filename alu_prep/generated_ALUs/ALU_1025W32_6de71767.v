`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: XOR, SUB, SLL, MAX, MUL, ADD, ROL, AND, PASSB, ROR, SEQ, SRL, OR
// Flags: carry, zero, overflow

module ALU_1025W32_6de71767(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam XOR = 4'd0;
    localparam SUB = 4'd1;
    localparam SLL = 4'd2;
    localparam MAX = 4'd3;
    localparam MUL = 4'd4;
    localparam ADD = 4'd5;
    localparam ROL = 4'd6;
    localparam AND = 4'd7;
    localparam PASSB = 4'd8;
    localparam ROR = 4'd9;
    localparam SEQ = 4'd10;
    localparam SRL = 4'd11;
    localparam OR = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[31] != input2[31]) && (result[31] != input1[31]);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            AND: begin
                result = input1 & input2;
            end
            PASSB: begin
                result = input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SEQ: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule