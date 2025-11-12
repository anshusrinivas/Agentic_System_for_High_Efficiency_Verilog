`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: XNOR, SRL, SRA, SUB, ROR, PASSB, AND
// Flags: carry, zero, overflow, sign

module ALU_1927W64_2095dad8(
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
    localparam XNOR = 4'd0;
    localparam SRL = 4'd1;
    localparam SRA = 4'd2;
    localparam SUB = 4'd3;
    localparam ROR = 4'd4;
    localparam PASSB = 4'd5;
    localparam AND = 4'd6;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            PASSB: begin
                result = input2;
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