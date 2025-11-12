`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: DIV, SNE, SRL, NOR, NAND, SLT, SUB, ADD, SLTU
// Flags: carry, zero, overflow, sign

module ALU_0133W64_e520279e(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam DIV = 4'd0;
    localparam SNE = 4'd1;
    localparam SRL = 4'd2;
    localparam NOR = 4'd3;
    localparam NAND = 4'd4;
    localparam SLT = 4'd5;
    localparam SUB = 4'd6;
    localparam ADD = 4'd7;
    localparam SLTU = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 64'b0;
            end
            SNE: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLT: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            SLTU: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule