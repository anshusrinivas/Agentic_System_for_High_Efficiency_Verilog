`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SGE, NAND, SLL, SGT, MIN, AND, NOR, SRA, XOR, ADD, MAX
// Flags: carry, zero, overflow, sign

module ALU_1084W8_8a3dc2eb(
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
    localparam SGE = 4'd0;
    localparam NAND = 4'd1;
    localparam SLL = 4'd2;
    localparam SGT = 4'd3;
    localparam MIN = 4'd4;
    localparam AND = 4'd5;
    localparam NOR = 4'd6;
    localparam SRA = 4'd7;
    localparam XOR = 4'd8;
    localparam ADD = 4'd9;
    localparam MAX = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGE: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SGT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            AND: begin
                result = input1 & input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
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