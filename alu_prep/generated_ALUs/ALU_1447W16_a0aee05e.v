`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: DIV, SRA, ROR, ROL, SGT, OR, AND, MAX, SLT, SGE, NAND, SLL
// Flags: carry, zero, overflow, sign

module ALU_1447W16_a0aee05e(
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
    localparam DIV = 4'd0;
    localparam SRA = 4'd1;
    localparam ROR = 4'd2;
    localparam ROL = 4'd3;
    localparam SGT = 4'd4;
    localparam OR = 4'd5;
    localparam AND = 4'd6;
    localparam MAX = 4'd7;
    localparam SLT = 4'd8;
    localparam SGE = 4'd9;
    localparam NAND = 4'd10;
    localparam SLL = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SGT: begin
            end
            OR: begin
                result = input1 | input2;
            end
            AND: begin
                result = input1 & input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SLT: begin
            end
            SGE: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule