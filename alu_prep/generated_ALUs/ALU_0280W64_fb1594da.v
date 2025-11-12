`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SLT, SRL, ROR, AND, MAX, SLL, SRA, OR, ROL
// Flags: carry, zero, sign

module ALU_0280W64_fb1594da(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SLT = 4'd0;
    localparam SRL = 4'd1;
    localparam ROR = 4'd2;
    localparam AND = 4'd3;
    localparam MAX = 4'd4;
    localparam SLL = 4'd5;
    localparam SRA = 4'd6;
    localparam OR = 4'd7;
    localparam ROL = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            AND: begin
                result = input1 & input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule