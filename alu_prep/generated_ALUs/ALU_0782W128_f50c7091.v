`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: MAX, XOR, SUB, SEQ, NOR, SNE, SLTU, PASSB, ROR, NAND
// Flags: carry, zero, overflow

module ALU_0782W128_f50c7091(
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
    localparam MAX = 4'd0;
    localparam XOR = 4'd1;
    localparam SUB = 4'd2;
    localparam SEQ = 4'd3;
    localparam NOR = 4'd4;
    localparam SNE = 4'd5;
    localparam SLTU = 4'd6;
    localparam PASSB = 4'd7;
    localparam ROR = 4'd8;
    localparam NAND = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            SEQ: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SNE: begin
            end
            SLTU: begin
            end
            PASSB: begin
                result = input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule