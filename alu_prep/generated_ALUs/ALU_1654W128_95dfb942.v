`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: XOR, MIN, SUB, PASSB, DIV, MAX, ROR, XNOR
// Flags: carry, zero, overflow, sign

module ALU_1654W128_95dfb942(
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
    localparam XOR = 4'd0;
    localparam MIN = 4'd1;
    localparam SUB = 4'd2;
    localparam PASSB = 4'd3;
    localparam DIV = 4'd4;
    localparam MAX = 4'd5;
    localparam ROR = 4'd6;
    localparam XNOR = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            PASSB: begin
                result = input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
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