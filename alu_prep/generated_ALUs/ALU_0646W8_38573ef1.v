`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: AND, ADD, OR, NAND, SEQ, SLTU, MIN, XOR, SLT, NOR, SRA, SGE
// Flags: carry, zero, overflow

module ALU_0646W8_38573ef1(
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
    localparam AND = 4'd0;
    localparam ADD = 4'd1;
    localparam OR = 4'd2;
    localparam NAND = 4'd3;
    localparam SEQ = 4'd4;
    localparam SLTU = 4'd5;
    localparam MIN = 4'd6;
    localparam XOR = 4'd7;
    localparam SLT = 4'd8;
    localparam NOR = 4'd9;
    localparam SRA = 4'd10;
    localparam SGE = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            AND: begin
                result = input1 & input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            OR: begin
                result = input1 | input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SEQ: begin
            end
            SLTU: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SLT: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGE: begin
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
    end

endmodule