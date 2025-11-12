`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SNE, PASSB, MUL, SLL, SUB, XOR, MAX, OR, SGE, SRL
// Flags: carry, zero, overflow, sign

module ALU_0382W128_8bc5e7c9(
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
    localparam SNE = 4'd0;
    localparam PASSB = 4'd1;
    localparam MUL = 4'd2;
    localparam SLL = 4'd3;
    localparam SUB = 4'd4;
    localparam XOR = 4'd5;
    localparam MAX = 4'd6;
    localparam OR = 4'd7;
    localparam SGE = 4'd8;
    localparam SRL = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SNE: begin
            end
            PASSB: begin
                result = input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SGE: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule