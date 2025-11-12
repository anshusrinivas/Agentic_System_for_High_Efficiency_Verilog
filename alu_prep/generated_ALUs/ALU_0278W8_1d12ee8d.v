`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SLT, SGE, OR, SLTU, AND, ADD, SEQ, SRA, XOR, MIN
// Flags: carry, zero, overflow, sign

module ALU_0278W8_1d12ee8d(
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
    localparam SLT = 4'd0;
    localparam SGE = 4'd1;
    localparam OR = 4'd2;
    localparam SLTU = 4'd3;
    localparam AND = 4'd4;
    localparam ADD = 4'd5;
    localparam SEQ = 4'd6;
    localparam SRA = 4'd7;
    localparam XOR = 4'd8;
    localparam MIN = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            SGE: begin
            end
            OR: begin
                result = input1 | input2;
            end
            SLTU: begin
            end
            AND: begin
                result = input1 & input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            SEQ: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
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