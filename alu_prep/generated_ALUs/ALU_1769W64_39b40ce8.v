`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: XNOR, SLL, SUB, MUL, SGE, SRA, NAND, MIN
// Flags: carry, zero, overflow

module ALU_1769W64_39b40ce8(
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
    localparam XNOR = 4'd0;
    localparam SLL = 4'd1;
    localparam SUB = 4'd2;
    localparam MUL = 4'd3;
    localparam SGE = 4'd4;
    localparam SRA = 4'd5;
    localparam NAND = 4'd6;
    localparam MIN = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            MUL: begin
                result = input1 * input2;
            end
            SGE: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule