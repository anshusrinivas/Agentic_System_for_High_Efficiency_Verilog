`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: MAX, ADD, AND, SUB, SNE, SRL
// Flags: carry, zero, overflow

module ALU_1112W8_f7f3f8ec(
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
    localparam MAX = 4'd0;
    localparam ADD = 4'd1;
    localparam AND = 4'd2;
    localparam SUB = 4'd3;
    localparam SNE = 4'd4;
    localparam SRL = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            AND: begin
                result = input1 & input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            SNE: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
    end

endmodule