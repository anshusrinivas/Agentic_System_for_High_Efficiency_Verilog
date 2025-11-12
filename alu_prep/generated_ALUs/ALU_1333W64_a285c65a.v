`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: ROR, AND, OR, SNE, SLT, SGT, SLL, XNOR, SUB, SRL, MAX, SEQ
// Flags: carry, zero, overflow

module ALU_1333W64_a285c65a(
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
    localparam ROR = 4'd0;
    localparam AND = 4'd1;
    localparam OR = 4'd2;
    localparam SNE = 4'd3;
    localparam SLT = 4'd4;
    localparam SGT = 4'd5;
    localparam SLL = 4'd6;
    localparam XNOR = 4'd7;
    localparam SUB = 4'd8;
    localparam SRL = 4'd9;
    localparam MAX = 4'd10;
    localparam SEQ = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROR: begin
                result = ror(input1, shiftValue);
            end
            AND: begin
                result = input1 & input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SNE: begin
            end
            SLT: begin
            end
            SGT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SEQ: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule