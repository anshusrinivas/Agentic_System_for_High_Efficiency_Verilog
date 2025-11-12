`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: ROL, SNE, SLT, SLTU, MAX, MIN, ADD, ROR, SRA, MUL
// Flags: carry, zero, overflow, sign

module ALU_1131W128_17a41d72(
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
    localparam ROL = 4'd0;
    localparam SNE = 4'd1;
    localparam SLT = 4'd2;
    localparam SLTU = 4'd3;
    localparam MAX = 4'd4;
    localparam MIN = 4'd5;
    localparam ADD = 4'd6;
    localparam ROR = 4'd7;
    localparam SRA = 4'd8;
    localparam MUL = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SNE: begin
            end
            SLT: begin
            end
            SLTU: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule