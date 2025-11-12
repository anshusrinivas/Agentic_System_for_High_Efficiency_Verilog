`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SLTU, DIV, MIN, SRA, AND, SLL, SUB, SNE, NAND, SLT, ROR
// Flags: carry, zero, overflow, sign

module ALU_0840W32_9fc3b149(
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
    localparam SLTU = 4'd0;
    localparam DIV = 4'd1;
    localparam MIN = 4'd2;
    localparam SRA = 4'd3;
    localparam AND = 4'd4;
    localparam SLL = 4'd5;
    localparam SUB = 4'd6;
    localparam SNE = 4'd7;
    localparam NAND = 4'd8;
    localparam SLT = 4'd9;
    localparam ROR = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLTU: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            AND: begin
                result = input1 & input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[31] != input2[31]) && (result[31] != input1[31]);
            end
            SNE: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLT: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule