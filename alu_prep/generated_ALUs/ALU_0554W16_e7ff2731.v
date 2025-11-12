`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLL, SLT, MAX, XOR, SUB, DIV, MUL, ADD, XNOR
// Flags: carry, zero, overflow

module ALU_0554W16_e7ff2731(
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
    localparam SLL = 4'd0;
    localparam SLT = 4'd1;
    localparam MAX = 4'd2;
    localparam XOR = 4'd3;
    localparam SUB = 4'd4;
    localparam DIV = 4'd5;
    localparam MUL = 4'd6;
    localparam ADD = 4'd7;
    localparam XNOR = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLL: begin
                result = input1 << shiftValue;
            end
            SLT: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule