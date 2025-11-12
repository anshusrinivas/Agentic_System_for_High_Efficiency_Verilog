`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: OR, SLL, SLTU, SRL, DIV, MUL, ROL, SLT, SEQ, ADD, SUB, XNOR, MAX
// Flags: carry, zero, overflow, sign

module ALU_1846W8_e176edb6(
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
    localparam OR = 4'd0;
    localparam SLL = 4'd1;
    localparam SLTU = 4'd2;
    localparam SRL = 4'd3;
    localparam DIV = 4'd4;
    localparam MUL = 4'd5;
    localparam ROL = 4'd6;
    localparam SLT = 4'd7;
    localparam SEQ = 4'd8;
    localparam ADD = 4'd9;
    localparam SUB = 4'd10;
    localparam XNOR = 4'd11;
    localparam MAX = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            OR: begin
                result = input1 | input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SLTU: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            MUL: begin
                result = input1 * input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
            end
            SEQ: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule