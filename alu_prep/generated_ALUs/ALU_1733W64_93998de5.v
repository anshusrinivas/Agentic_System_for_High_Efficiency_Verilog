`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SUB, SNE, ROL, SLT, MUL, SRL, MIN, NAND, SGT, ROR
// Flags: carry, zero, overflow, sign

module ALU_1733W64_93998de5(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SUB = 4'd0;
    localparam SNE = 4'd1;
    localparam ROL = 4'd2;
    localparam SLT = 4'd3;
    localparam MUL = 4'd4;
    localparam SRL = 4'd5;
    localparam MIN = 4'd6;
    localparam NAND = 4'd7;
    localparam SGT = 4'd8;
    localparam ROR = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            SNE: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SGT: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule