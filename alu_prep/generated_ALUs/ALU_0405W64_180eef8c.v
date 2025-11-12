`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SEQ, MIN, NOR, SGT, XOR, SUB, ROL, ADD, NAND, SLL
// Flags: carry, zero, overflow, sign

module ALU_0405W64_180eef8c(
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
    localparam SEQ = 4'd0;
    localparam MIN = 4'd1;
    localparam NOR = 4'd2;
    localparam SGT = 4'd3;
    localparam XOR = 4'd4;
    localparam SUB = 4'd5;
    localparam ROL = 4'd6;
    localparam ADD = 4'd7;
    localparam NAND = 4'd8;
    localparam SLL = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SEQ: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SGT: begin
            end
            XOR: begin
                result = input1 ^ input2;
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
            NAND: begin
                result = ~(input1 & input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule