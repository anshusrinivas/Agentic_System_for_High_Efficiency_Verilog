`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SLT, SRA, NAND, ADD, ROL, SNE, SGT, SUB, SLTU
// Flags: carry, zero, overflow

module ALU_0800W8_23660788(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SLT = 4'd0;
    localparam SRA = 4'd1;
    localparam NAND = 4'd2;
    localparam ADD = 4'd3;
    localparam ROL = 4'd4;
    localparam SNE = 4'd5;
    localparam SGT = 4'd6;
    localparam SUB = 4'd7;
    localparam SLTU = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SNE: begin
            end
            SGT: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            SLTU: begin
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
    end

endmodule