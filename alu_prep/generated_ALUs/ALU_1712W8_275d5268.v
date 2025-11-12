`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: NOR, SRA, SLL, PASSB, OR, SLTU, SUB, AND, SRL, SGT, SLT, NAND, XOR
// Flags: carry, zero, sign

module ALU_1712W8_275d5268(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam NOR = 4'd0;
    localparam SRA = 4'd1;
    localparam SLL = 4'd2;
    localparam PASSB = 4'd3;
    localparam OR = 4'd4;
    localparam SLTU = 4'd5;
    localparam SUB = 4'd6;
    localparam AND = 4'd7;
    localparam SRL = 4'd8;
    localparam SGT = 4'd9;
    localparam SLT = 4'd10;
    localparam NAND = 4'd11;
    localparam XOR = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SLTU: begin
            end
            SUB: begin
                result = input1 - input2;
                
            end
            AND: begin
                result = input1 & input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGT: begin
            end
            SLT: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule