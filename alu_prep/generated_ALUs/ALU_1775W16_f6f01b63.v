`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLT, SLL, SRL, OR, MAX, DIV, SLTU, SUB, MIN, SRA
// Flags: carry, zero, overflow, sign

module ALU_1775W16_f6f01b63(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SLT = 4'd0;
    localparam SLL = 4'd1;
    localparam SRL = 4'd2;
    localparam OR = 4'd3;
    localparam MAX = 4'd4;
    localparam DIV = 4'd5;
    localparam SLTU = 4'd6;
    localparam SUB = 4'd7;
    localparam MIN = 4'd8;
    localparam SRA = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SLTU: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule