`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: MUL, SGT, XNOR, ROL, SGE, NOR, OR, MIN, ADD, SRA, SNE
// Flags: carry, zero, overflow

module ALU_1904W64_1bf04338(
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
    localparam MUL = 4'd0;
    localparam SGT = 4'd1;
    localparam XNOR = 4'd2;
    localparam ROL = 4'd3;
    localparam SGE = 4'd4;
    localparam NOR = 4'd5;
    localparam OR = 4'd6;
    localparam MIN = 4'd7;
    localparam ADD = 4'd8;
    localparam SRA = 4'd9;
    localparam SNE = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MUL: begin
                result = input1 * input2;
            end
            SGT: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SGE: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            OR: begin
                result = input1 | input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SNE: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule