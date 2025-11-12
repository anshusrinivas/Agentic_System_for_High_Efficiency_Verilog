`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SGT, OR, AND, PASSB, DIV, SRL, SGE, SUB, MUL, SRA, XNOR, ADD
// Flags: carry, zero, overflow, sign

module ALU_0101W32_9ef2c16f(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SGT = 4'd0;
    localparam OR = 4'd1;
    localparam AND = 4'd2;
    localparam PASSB = 4'd3;
    localparam DIV = 4'd4;
    localparam SRL = 4'd5;
    localparam SGE = 4'd6;
    localparam SUB = 4'd7;
    localparam MUL = 4'd8;
    localparam SRA = 4'd9;
    localparam XNOR = 4'd10;
    localparam ADD = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            OR: begin
                result = input1 | input2;
            end
            AND: begin
                result = input1 & input2;
            end
            PASSB: begin
                result = input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGE: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[31] != input2[31]) && (result[31] != input1[31]);
            end
            MUL: begin
                result = input1 * input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule