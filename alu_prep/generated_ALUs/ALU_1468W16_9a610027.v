`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: XOR, NAND, XNOR, SNE, SRA, ROR
// Flags: carry, zero, overflow, sign

module ALU_1468W16_9a610027(
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
    localparam XOR = 4'd0;
    localparam NAND = 4'd1;
    localparam XNOR = 4'd2;
    localparam SNE = 4'd3;
    localparam SRA = 4'd4;
    localparam ROR = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SNE: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule