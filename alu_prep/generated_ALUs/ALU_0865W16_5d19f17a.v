`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLL, SRA, ROR, SEQ, AND, MAX, MUL, NOR, XNOR, MIN
// Flags: carry, zero, overflow, sign

module ALU_0865W16_5d19f17a(
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
    localparam SLL = 4'd0;
    localparam SRA = 4'd1;
    localparam ROR = 4'd2;
    localparam SEQ = 4'd3;
    localparam AND = 4'd4;
    localparam MAX = 4'd5;
    localparam MUL = 4'd6;
    localparam NOR = 4'd7;
    localparam XNOR = 4'd8;
    localparam MIN = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLL: begin
                result = input1 << shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SEQ: begin
            end
            AND: begin
                result = input1 & input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule