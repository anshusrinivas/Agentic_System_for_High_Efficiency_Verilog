`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: MUL, SLT, SLTU, ADD, XOR, SRA, MAX, MIN
// Flags: carry, zero, overflow, sign

module ALU_1891W8_2e750635(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam MUL = 4'd0;
    localparam SLT = 4'd1;
    localparam SLTU = 4'd2;
    localparam ADD = 4'd3;
    localparam XOR = 4'd4;
    localparam SRA = 4'd5;
    localparam MAX = 4'd6;
    localparam MIN = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MUL: begin
                result = input1 * input2;
            end
            SLT: begin
            end
            SLTU: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule