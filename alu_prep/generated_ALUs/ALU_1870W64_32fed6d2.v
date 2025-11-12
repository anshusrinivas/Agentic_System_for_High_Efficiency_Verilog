`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: PASSB, SRL, NAND, SUB, SGE, SNE, XOR, OR, NOR, AND, SGT, XNOR
// Flags: carry, zero, overflow

module ALU_1870W64_32fed6d2(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam PASSB = 4'd0;
    localparam SRL = 4'd1;
    localparam NAND = 4'd2;
    localparam SUB = 4'd3;
    localparam SGE = 4'd4;
    localparam SNE = 4'd5;
    localparam XOR = 4'd6;
    localparam OR = 4'd7;
    localparam NOR = 4'd8;
    localparam AND = 4'd9;
    localparam SGT = 4'd10;
    localparam XNOR = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            PASSB: begin
                result = input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            SGE: begin
            end
            SNE: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            OR: begin
                result = input1 | input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            AND: begin
                result = input1 & input2;
            end
            SGT: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule