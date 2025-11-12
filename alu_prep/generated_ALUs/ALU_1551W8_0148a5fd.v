`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: MUL, ADD, SNE, SEQ, SLL, NAND
// Flags: carry, zero, overflow, sign

module ALU_1551W8_0148a5fd(
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
    localparam MUL = 4'd0;
    localparam ADD = 4'd1;
    localparam SNE = 4'd2;
    localparam SEQ = 4'd3;
    localparam SLL = 4'd4;
    localparam NAND = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            SNE: begin
            end
            SEQ: begin
            end
            SLL: begin
                result = input1 << shiftValue;
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