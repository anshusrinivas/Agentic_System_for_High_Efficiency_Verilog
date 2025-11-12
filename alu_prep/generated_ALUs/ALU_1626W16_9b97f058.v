`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLT, DIV, ROR, ADD, OR, XNOR, SGE, SRA, SRL, SUB, NAND, SLL
// Flags: carry, zero, overflow

module ALU_1626W16_9b97f058(
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
    localparam SLT = 4'd0;
    localparam DIV = 4'd1;
    localparam ROR = 4'd2;
    localparam ADD = 4'd3;
    localparam OR = 4'd4;
    localparam XNOR = 4'd5;
    localparam SGE = 4'd6;
    localparam SRA = 4'd7;
    localparam SRL = 4'd8;
    localparam SUB = 4'd9;
    localparam NAND = 4'd10;
    localparam SLL = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
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
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SGE: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule