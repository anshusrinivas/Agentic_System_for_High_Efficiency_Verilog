`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SLT, SLL, SRA, SUB, SRL, AND
// Flags: carry, zero, sign

module ALU_1962W64_72cdf984(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SLT = 4'd0;
    localparam SLL = 4'd1;
    localparam SRA = 4'd2;
    localparam SUB = 4'd3;
    localparam SRL = 4'd4;
    localparam AND = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            AND: begin
                result = input1 & input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule