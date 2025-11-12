`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SGE, OR, MAX, NAND, SGT, SRL
// Flags: carry, zero, overflow, sign

module ALU_1476W16_aaa13d0e(
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
    localparam SGE = 4'd0;
    localparam OR = 4'd1;
    localparam MAX = 4'd2;
    localparam NAND = 4'd3;
    localparam SGT = 4'd4;
    localparam SRL = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGE: begin
            end
            OR: begin
                result = input1 | input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SGT: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule