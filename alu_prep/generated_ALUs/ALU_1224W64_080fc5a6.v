`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: XOR, SGT, SUB, NOR, SLTU, MAX, XNOR, MUL, NAND, SLL, MIN, SLT
// Flags: carry, zero, overflow

module ALU_1224W64_080fc5a6(
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
    localparam XOR = 4'd0;
    localparam SGT = 4'd1;
    localparam SUB = 4'd2;
    localparam NOR = 4'd3;
    localparam SLTU = 4'd4;
    localparam MAX = 4'd5;
    localparam XNOR = 4'd6;
    localparam MUL = 4'd7;
    localparam NAND = 4'd8;
    localparam SLL = 4'd9;
    localparam MIN = 4'd10;
    localparam SLT = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            SGT: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLTU: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLT: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule