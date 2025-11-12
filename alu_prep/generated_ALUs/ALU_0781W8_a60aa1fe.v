`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: MIN, MUL, PASSB, MAX, ADD, SNE, SRL, DIV, XOR, SEQ, SUB, AND, SRA, NAND
// Flags: carry, zero, overflow, sign

module ALU_0781W8_a60aa1fe(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam MIN = 4'd0;
    localparam MUL = 4'd1;
    localparam PASSB = 4'd2;
    localparam MAX = 4'd3;
    localparam ADD = 4'd4;
    localparam SNE = 4'd5;
    localparam SRL = 4'd6;
    localparam DIV = 4'd7;
    localparam XOR = 4'd8;
    localparam SEQ = 4'd9;
    localparam SUB = 4'd10;
    localparam AND = 4'd11;
    localparam SRA = 4'd12;
    localparam NAND = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            PASSB: begin
                result = input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            SNE: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SEQ: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            AND: begin
                result = input1 & input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule