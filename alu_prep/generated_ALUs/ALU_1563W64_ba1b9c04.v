`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SLT, SLL, PASSB, SEQ, AND, SGE, NAND, SUB, ROL, ADD, MUL, SNE, OR
// Flags: carry, zero, overflow, sign

module ALU_1563W64_ba1b9c04(
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
    localparam SLT = 4'd0;
    localparam SLL = 4'd1;
    localparam PASSB = 4'd2;
    localparam SEQ = 4'd3;
    localparam AND = 4'd4;
    localparam SGE = 4'd5;
    localparam NAND = 4'd6;
    localparam SUB = 4'd7;
    localparam ROL = 4'd8;
    localparam ADD = 4'd9;
    localparam MUL = 4'd10;
    localparam SNE = 4'd11;
    localparam OR = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            SEQ: begin
            end
            AND: begin
                result = input1 & input2;
            end
            SGE: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            MUL: begin
                result = input1 * input2;
            end
            SNE: begin
            end
            OR: begin
                result = input1 | input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule