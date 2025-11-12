`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: NOR, AND, SLL, PASSB, SUB, XNOR, SGT, SLT, SEQ, XOR
// Flags: carry, zero, overflow, sign

module ALU_0734W16_fa85f195(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam NOR = 4'd0;
    localparam AND = 4'd1;
    localparam SLL = 4'd2;
    localparam PASSB = 4'd3;
    localparam SUB = 4'd4;
    localparam XNOR = 4'd5;
    localparam SGT = 4'd6;
    localparam SLT = 4'd7;
    localparam SEQ = 4'd8;
    localparam XOR = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            AND: begin
                result = input1 & input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SGT: begin
            end
            SLT: begin
            end
            SEQ: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule