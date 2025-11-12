`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SLT, SUB, SLTU, SLL, MIN, ROR, SRL, MAX, SRA, MUL
// Flags: carry, zero, overflow, sign

module ALU_1178W64_de3e892b(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SLT = 4'd0;
    localparam SUB = 4'd1;
    localparam SLTU = 4'd2;
    localparam SLL = 4'd3;
    localparam MIN = 4'd4;
    localparam ROR = 4'd5;
    localparam SRL = 4'd6;
    localparam MAX = 4'd7;
    localparam SRA = 4'd8;
    localparam MUL = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            SLTU: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule