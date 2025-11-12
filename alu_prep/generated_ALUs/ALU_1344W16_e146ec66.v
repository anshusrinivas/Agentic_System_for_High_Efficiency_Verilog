`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRL, SLL, NAND, MUL, MAX, ADD, SNE, SUB, XNOR, SGT, XOR, MIN
// Flags: carry, zero, overflow

module ALU_1344W16_e146ec66(
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
    localparam SRL = 4'd0;
    localparam SLL = 4'd1;
    localparam NAND = 4'd2;
    localparam MUL = 4'd3;
    localparam MAX = 4'd4;
    localparam ADD = 4'd5;
    localparam SNE = 4'd6;
    localparam SUB = 4'd7;
    localparam XNOR = 4'd8;
    localparam SGT = 4'd9;
    localparam XOR = 4'd10;
    localparam MIN = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            SNE: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SGT: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule