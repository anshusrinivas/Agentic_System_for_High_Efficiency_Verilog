`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SLT, NOR, SLL, SUB, SLTU, SEQ, OR, MAX, NAND, SRA, MUL, SNE
// Flags: carry, zero, sign

module ALU_0095W8_2f79005b(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SLT = 4'd0;
    localparam NOR = 4'd1;
    localparam SLL = 4'd2;
    localparam SUB = 4'd3;
    localparam SLTU = 4'd4;
    localparam SEQ = 4'd5;
    localparam OR = 4'd6;
    localparam MAX = 4'd7;
    localparam NAND = 4'd8;
    localparam SRA = 4'd9;
    localparam MUL = 4'd10;
    localparam SNE = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SLTU: begin
            end
            SEQ: begin
            end
            OR: begin
                result = input1 | input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MUL: begin
                result = input1 * input2;
            end
            SNE: begin
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule