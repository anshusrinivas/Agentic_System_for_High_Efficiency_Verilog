`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: ROR, SNE, SRA, SUB, ROL, OR
// Flags: carry, zero, overflow

module ALU_1451W128_23187565(
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
    localparam ROR = 4'd0;
    localparam SNE = 4'd1;
    localparam SRA = 4'd2;
    localparam SUB = 4'd3;
    localparam ROL = 4'd4;
    localparam OR = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SNE: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            OR: begin
                result = input1 | input2;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule