`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: NAND, SGE, XOR, MUL, SUB, SRL, SGT, PASSB, ROR, MAX, SLL, SNE
// Flags: carry, zero, overflow

module ALU_0480W128_621d77aa(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam NAND = 4'd0;
    localparam SGE = 4'd1;
    localparam XOR = 4'd2;
    localparam MUL = 4'd3;
    localparam SUB = 4'd4;
    localparam SRL = 4'd5;
    localparam SGT = 4'd6;
    localparam PASSB = 4'd7;
    localparam ROR = 4'd8;
    localparam MAX = 4'd9;
    localparam SLL = 4'd10;
    localparam SNE = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NAND: begin
                result = ~(input1 & input2);
            end
            SGE: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGT: begin
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
            SLL: begin
                result = input1 << shiftValue;
            end
            SNE: begin
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule