`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: MAX, DIV, NAND, PASSB, NOR, OR, MIN, ROR, XOR, SLT, SUB
// Flags: carry, zero, sign

module ALU_1085W32_1c499acf(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam MAX = 4'd0;
    localparam DIV = 4'd1;
    localparam NAND = 4'd2;
    localparam PASSB = 4'd3;
    localparam NOR = 4'd4;
    localparam OR = 4'd5;
    localparam MIN = 4'd6;
    localparam ROR = 4'd7;
    localparam XOR = 4'd8;
    localparam SLT = 4'd9;
    localparam SUB = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            PASSB: begin
                result = input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            OR: begin
                result = input1 | input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SLT: begin
            end
            SUB: begin
                result = input1 - input2;
                
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule