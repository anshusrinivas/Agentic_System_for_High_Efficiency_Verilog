`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SLL, NAND, SUB, MAX, SNE, ROR, MIN, XOR
// Flags: carry, zero, overflow

module ALU_1720W128_9c05d7c3(
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
    localparam SLL = 4'd0;
    localparam NAND = 4'd1;
    localparam SUB = 4'd2;
    localparam MAX = 4'd3;
    localparam SNE = 4'd4;
    localparam ROR = 4'd5;
    localparam MIN = 4'd6;
    localparam XOR = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLL: begin
                result = input1 << shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SNE: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule