`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SNE, OR, MUL, ROL, SEQ, AND, SLL, ADD, MIN, SRL, SGE
// Flags: carry, zero, overflow

module ALU_1635W128_b9b2e341(
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
    localparam SNE = 4'd0;
    localparam OR = 4'd1;
    localparam MUL = 4'd2;
    localparam ROL = 4'd3;
    localparam SEQ = 4'd4;
    localparam AND = 4'd5;
    localparam SLL = 4'd6;
    localparam ADD = 4'd7;
    localparam MIN = 4'd8;
    localparam SRL = 4'd9;
    localparam SGE = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SNE: begin
            end
            OR: begin
                result = input1 | input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SEQ: begin
            end
            AND: begin
                result = input1 & input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGE: begin
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule