`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: ROR, SUB, NAND, SRL, DIV, SLL
// Flags: carry, zero, overflow

module ALU_1297W16_8a3c5d68(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam ROR = 4'd0;
    localparam SUB = 4'd1;
    localparam NAND = 4'd2;
    localparam SRL = 4'd3;
    localparam DIV = 4'd4;
    localparam SLL = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule