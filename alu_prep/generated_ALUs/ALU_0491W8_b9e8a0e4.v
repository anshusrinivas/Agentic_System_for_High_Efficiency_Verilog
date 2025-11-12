`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SUB, MUL, XOR, PASSB, MAX, SRL, OR, SEQ, DIV, MIN, SLL, ADD
// Flags: carry, zero, overflow

module ALU_0491W8_b9e8a0e4(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SUB = 4'd0;
    localparam MUL = 4'd1;
    localparam XOR = 4'd2;
    localparam PASSB = 4'd3;
    localparam MAX = 4'd4;
    localparam SRL = 4'd5;
    localparam OR = 4'd6;
    localparam SEQ = 4'd7;
    localparam DIV = 4'd8;
    localparam MIN = 4'd9;
    localparam SLL = 4'd10;
    localparam ADD = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            MUL: begin
                result = input1 * input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            PASSB: begin
                result = input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            SEQ: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
    end

endmodule