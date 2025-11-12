`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SGE, SUB, XOR, NAND, PASSB, SRL, MIN, SRA, ROR, ADD, OR, SLT
// Flags: carry, zero, overflow

module ALU_1489W16_c329820e(
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
    localparam SGE = 4'd0;
    localparam SUB = 4'd1;
    localparam XOR = 4'd2;
    localparam NAND = 4'd3;
    localparam PASSB = 4'd4;
    localparam SRL = 4'd5;
    localparam MIN = 4'd6;
    localparam SRA = 4'd7;
    localparam ROR = 4'd8;
    localparam ADD = 4'd9;
    localparam OR = 4'd10;
    localparam SLT = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGE: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            PASSB: begin
                result = input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            OR: begin
                result = input1 | input2;
            end
            SLT: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule