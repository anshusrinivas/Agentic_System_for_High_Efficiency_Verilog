`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SRL, NAND, ROR, NOR, MAX, SLL, ROL, MUL
// Flags: carry, zero, overflow, sign

module ALU_1395W64_a17f2330(
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
    localparam SRL = 4'd0;
    localparam NAND = 4'd1;
    localparam ROR = 4'd2;
    localparam NOR = 4'd3;
    localparam MAX = 4'd4;
    localparam SLL = 4'd5;
    localparam ROL = 4'd6;
    localparam MUL = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule