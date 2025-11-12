`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: NAND, SRA, SEQ, ROL, XNOR, XOR, MAX
// Flags: carry, zero, overflow, sign

module ALU_1144W8_01d07a30(
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
    localparam NAND = 4'd0;
    localparam SRA = 4'd1;
    localparam SEQ = 4'd2;
    localparam ROL = 4'd3;
    localparam XNOR = 4'd4;
    localparam XOR = 4'd5;
    localparam MAX = 4'd6;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NAND: begin
                result = ~(input1 & input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SEQ: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            XOR: begin
                result = input1 ^ input2;
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