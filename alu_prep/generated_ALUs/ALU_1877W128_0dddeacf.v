`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SEQ, SLT, SNE, AND, SUB, SRL, MIN, XOR, MUL, SRA, XNOR
// Flags: carry, zero, sign

module ALU_1877W128_0dddeacf(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SEQ = 4'd0;
    localparam SLT = 4'd1;
    localparam SNE = 4'd2;
    localparam AND = 4'd3;
    localparam SUB = 4'd4;
    localparam SRL = 4'd5;
    localparam MIN = 4'd6;
    localparam XOR = 4'd7;
    localparam MUL = 4'd8;
    localparam SRA = 4'd9;
    localparam XNOR = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SEQ: begin
            end
            SLT: begin
            end
            SNE: begin
            end
            AND: begin
                result = input1 & input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule