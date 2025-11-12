`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: ROR, XNOR, SRA, SLL, NOR, OR, NAND, SRL, SGE, AND, MUL
// Flags: carry, zero, overflow

module ALU_0032W16_290b97af(
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
    localparam ROR = 4'd0;
    localparam XNOR = 4'd1;
    localparam SRA = 4'd2;
    localparam SLL = 4'd3;
    localparam NOR = 4'd4;
    localparam OR = 4'd5;
    localparam NAND = 4'd6;
    localparam SRL = 4'd7;
    localparam SGE = 4'd8;
    localparam AND = 4'd9;
    localparam MUL = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROR: begin
                result = ror(input1, shiftValue);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            OR: begin
                result = input1 | input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGE: begin
            end
            AND: begin
                result = input1 & input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule