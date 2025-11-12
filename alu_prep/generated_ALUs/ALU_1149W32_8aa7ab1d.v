`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: ADD, NOR, MAX, SUB, AND, NAND, MUL, SNE, SLL, SRA, DIV, SRL
// Flags: carry, zero, overflow

module ALU_1149W32_8aa7ab1d(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam NOR = 4'd1;
    localparam MAX = 4'd2;
    localparam SUB = 4'd3;
    localparam AND = 4'd4;
    localparam NAND = 4'd5;
    localparam MUL = 4'd6;
    localparam SNE = 4'd7;
    localparam SLL = 4'd8;
    localparam SRA = 4'd9;
    localparam DIV = 4'd10;
    localparam SRL = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[31] != input2[31]) && (result[31] != input1[31]);
            end
            AND: begin
                result = input1 & input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            SNE: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule