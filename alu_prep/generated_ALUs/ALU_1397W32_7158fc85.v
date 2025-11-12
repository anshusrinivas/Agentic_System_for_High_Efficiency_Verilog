`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: OR, SUB, SRA, SEQ, ROR, XOR, MIN, DIV
// Flags: carry, zero, sign

module ALU_1397W32_7158fc85(
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
    localparam OR = 4'd0;
    localparam SUB = 4'd1;
    localparam SRA = 4'd2;
    localparam SEQ = 4'd3;
    localparam ROR = 4'd4;
    localparam XOR = 4'd5;
    localparam MIN = 4'd6;
    localparam DIV = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            OR: begin
                result = input1 | input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SEQ: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule