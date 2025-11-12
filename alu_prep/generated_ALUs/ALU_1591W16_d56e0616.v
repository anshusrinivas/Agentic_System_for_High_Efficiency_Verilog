`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: OR, SRA, ROR, NAND, MUL, MAX, ROL, SLL
// Flags: carry, zero, overflow

module ALU_1591W16_d56e0616(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam OR = 4'd0;
    localparam SRA = 4'd1;
    localparam ROR = 4'd2;
    localparam NAND = 4'd3;
    localparam MUL = 4'd4;
    localparam MAX = 4'd5;
    localparam ROL = 4'd6;
    localparam SLL = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            OR: begin
                result = input1 | input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule