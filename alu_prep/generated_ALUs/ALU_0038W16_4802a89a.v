`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: AND, SRA, NAND, ROR, MAX, SLT
// Flags: carry, zero, overflow

module ALU_0038W16_4802a89a(
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
    localparam AND = 4'd0;
    localparam SRA = 4'd1;
    localparam NAND = 4'd2;
    localparam ROR = 4'd3;
    localparam MAX = 4'd4;
    localparam SLT = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            AND: begin
                result = input1 & input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SLT: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule