`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SEQ, PASSB, SLL, MUL, ROR, SUB, SNE, XOR, SLTU, AND, SGE, ADD
// Flags: carry, zero, overflow, sign

module ALU_0789W128_fa6f78dd(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SEQ = 4'd0;
    localparam PASSB = 4'd1;
    localparam SLL = 4'd2;
    localparam MUL = 4'd3;
    localparam ROR = 4'd4;
    localparam SUB = 4'd5;
    localparam SNE = 4'd6;
    localparam XOR = 4'd7;
    localparam SLTU = 4'd8;
    localparam AND = 4'd9;
    localparam SGE = 4'd10;
    localparam ADD = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SEQ: begin
            end
            PASSB: begin
                result = input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            MUL: begin
                result = input1 * input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            SNE: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SLTU: begin
            end
            AND: begin
                result = input1 & input2;
            end
            SGE: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule