`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SLL, SRA, SUB, OR, PASSB, ROR, MAX, SNE, NAND, MUL, SRL
// Flags: carry, zero, overflow

module ALU_1661W32_774b42ad(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SLL = 4'd0;
    localparam SRA = 4'd1;
    localparam SUB = 4'd2;
    localparam OR = 4'd3;
    localparam PASSB = 4'd4;
    localparam ROR = 4'd5;
    localparam MAX = 4'd6;
    localparam SNE = 4'd7;
    localparam NAND = 4'd8;
    localparam MUL = 4'd9;
    localparam SRL = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLL: begin
                result = input1 << shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[31] != input2[31]) && (result[31] != input1[31]);
            end
            OR: begin
                result = input1 | input2;
            end
            PASSB: begin
                result = input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SNE: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule