`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SLTU, NOR, AND, SRA, XNOR, OR, SRL, SEQ, SGT, XOR, ROR
// Flags: carry, zero, sign

module ALU_1438W64_30e8ac54(
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
    localparam SLTU = 4'd0;
    localparam NOR = 4'd1;
    localparam AND = 4'd2;
    localparam SRA = 4'd3;
    localparam XNOR = 4'd4;
    localparam OR = 4'd5;
    localparam SRL = 4'd6;
    localparam SEQ = 4'd7;
    localparam SGT = 4'd8;
    localparam XOR = 4'd9;
    localparam ROR = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLTU: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            AND: begin
                result = input1 & input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            OR: begin
                result = input1 | input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SEQ: begin
            end
            SGT: begin
            end
            XOR: begin
                result = input1 ^ input2;
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