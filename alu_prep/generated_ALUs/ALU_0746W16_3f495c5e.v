`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: MAX, SRA, NAND, OR, SGT, MUL, ROR, SLT, SGE, NOR, SRL
// Flags: carry, zero, overflow

module ALU_0746W16_3f495c5e(
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
    localparam MAX = 4'd0;
    localparam SRA = 4'd1;
    localparam NAND = 4'd2;
    localparam OR = 4'd3;
    localparam SGT = 4'd4;
    localparam MUL = 4'd5;
    localparam ROR = 4'd6;
    localparam SLT = 4'd7;
    localparam SGE = 4'd8;
    localparam NOR = 4'd9;
    localparam SRL = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            OR: begin
                result = input1 | input2;
            end
            SGT: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SLT: begin
            end
            SGE: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule