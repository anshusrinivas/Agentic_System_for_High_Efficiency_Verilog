`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SLT, MUL, SGT, ADD, MAX, SRA, ROR, PASSB, NAND
// Flags: carry, zero, overflow

module ALU_0476W128_26eb2756(
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
    localparam SLT = 4'd0;
    localparam MUL = 4'd1;
    localparam SGT = 4'd2;
    localparam ADD = 4'd3;
    localparam MAX = 4'd4;
    localparam SRA = 4'd5;
    localparam ROR = 4'd6;
    localparam PASSB = 4'd7;
    localparam NAND = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SGT: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            PASSB: begin
                result = input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule