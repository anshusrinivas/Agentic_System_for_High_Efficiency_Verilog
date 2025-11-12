`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SLT, MUL, OR, SNE, PASSB, SLL, SEQ, SGE, SUB, ADD, NOR
// Flags: carry, zero, overflow

module ALU_1907W8_4ade1a5a(
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
    localparam MUL = 4'd1;
    localparam OR = 4'd2;
    localparam SNE = 4'd3;
    localparam PASSB = 4'd4;
    localparam SLL = 4'd5;
    localparam SEQ = 4'd6;
    localparam SGE = 4'd7;
    localparam SUB = 4'd8;
    localparam ADD = 4'd9;
    localparam NOR = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SNE: begin
            end
            PASSB: begin
                result = input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SEQ: begin
            end
            SGE: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
    end

endmodule