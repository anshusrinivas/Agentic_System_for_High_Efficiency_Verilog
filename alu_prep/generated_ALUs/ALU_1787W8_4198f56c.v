`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: MIN, NOR, NAND, SUB, OR, AND, ADD, DIV, SRL, SLT, XOR
// Flags: carry, zero, sign

module ALU_1787W8_4198f56c(
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
    localparam MIN = 4'd0;
    localparam NOR = 4'd1;
    localparam NAND = 4'd2;
    localparam SUB = 4'd3;
    localparam OR = 4'd4;
    localparam AND = 4'd5;
    localparam ADD = 4'd6;
    localparam DIV = 4'd7;
    localparam SRL = 4'd8;
    localparam SLT = 4'd9;
    localparam XOR = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SUB: begin
                result = input1 - input2;
                
            end
            OR: begin
                result = input1 | input2;
            end
            AND: begin
                result = input1 & input2;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SLT: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule