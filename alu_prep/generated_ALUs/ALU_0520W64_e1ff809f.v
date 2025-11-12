`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: XNOR, NAND, PASSB, OR, SRA, ADD, NOR, SLT, AND, SEQ
// Flags: carry, zero, overflow, sign

module ALU_0520W64_e1ff809f(
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
    localparam XNOR = 4'd0;
    localparam NAND = 4'd1;
    localparam PASSB = 4'd2;
    localparam OR = 4'd3;
    localparam SRA = 4'd4;
    localparam ADD = 4'd5;
    localparam NOR = 4'd6;
    localparam SLT = 4'd7;
    localparam AND = 4'd8;
    localparam SEQ = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            PASSB: begin
                result = input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLT: begin
            end
            AND: begin
                result = input1 & input2;
            end
            SEQ: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule