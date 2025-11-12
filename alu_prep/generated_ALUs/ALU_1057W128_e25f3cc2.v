`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SRL, MIN, MUL, AND, SGE, XNOR, ROR, OR, SLL, NAND, XOR, ROL, SLT, SRA
// Flags: carry, zero, overflow, sign

module ALU_1057W128_e25f3cc2(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SRL = 4'd0;
    localparam MIN = 4'd1;
    localparam MUL = 4'd2;
    localparam AND = 4'd3;
    localparam SGE = 4'd4;
    localparam XNOR = 4'd5;
    localparam ROR = 4'd6;
    localparam OR = 4'd7;
    localparam SLL = 4'd8;
    localparam NAND = 4'd9;
    localparam XOR = 4'd10;
    localparam ROL = 4'd11;
    localparam SLT = 4'd12;
    localparam SRA = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SGE: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            OR: begin
                result = input1 | input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule