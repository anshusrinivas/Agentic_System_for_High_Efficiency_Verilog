`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: XOR, ADD, SLT, MIN, MUL, OR, SEQ, SRL, ROR, SGE, SLL
// Flags: carry, zero, overflow

module ALU_0363W64_91b0c3cb(
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
    localparam ADD = 4'd1;
    localparam SLT = 4'd2;
    localparam MIN = 4'd3;
    localparam MUL = 4'd4;
    localparam OR = 4'd5;
    localparam SEQ = 4'd6;
    localparam SRL = 4'd7;
    localparam ROR = 4'd8;
    localparam SGE = 4'd9;
    localparam SLL = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            SLT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SEQ: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SGE: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule