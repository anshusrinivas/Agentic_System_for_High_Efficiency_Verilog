`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: PASSB, NAND, DIV, SRA, XNOR, MAX, ADD, AND, SUB, XOR, ROR, SNE, MUL, SLTU
// Flags: carry, zero, overflow

module ALU_1589W16_97017063(
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
    localparam PASSB = 4'd0;
    localparam NAND = 4'd1;
    localparam DIV = 4'd2;
    localparam SRA = 4'd3;
    localparam XNOR = 4'd4;
    localparam MAX = 4'd5;
    localparam ADD = 4'd6;
    localparam AND = 4'd7;
    localparam SUB = 4'd8;
    localparam XOR = 4'd9;
    localparam ROR = 4'd10;
    localparam SNE = 4'd11;
    localparam MUL = 4'd12;
    localparam SLTU = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            PASSB: begin
                result = input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            AND: begin
                result = input1 & input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SNE: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SLTU: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule