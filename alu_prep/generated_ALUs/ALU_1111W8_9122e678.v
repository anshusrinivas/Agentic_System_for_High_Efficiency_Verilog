`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SUB, SEQ, XOR, NAND, OR, MUL
// Flags: carry, zero, overflow, sign

module ALU_1111W8_9122e678(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SUB = 4'd0;
    localparam SEQ = 4'd1;
    localparam XOR = 4'd2;
    localparam NAND = 4'd3;
    localparam OR = 4'd4;
    localparam MUL = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            SEQ: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            OR: begin
                result = input1 | input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule