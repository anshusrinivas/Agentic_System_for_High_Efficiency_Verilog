`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SGT, AND, MIN, SUB, ADD, SRA, ROR, SRL, SLT, SLTU, SEQ, ROL, XOR
// Flags: carry, zero, overflow, sign

module ALU_0678W8_868fb8a7(
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
    localparam SGT = 4'd0;
    localparam AND = 4'd1;
    localparam MIN = 4'd2;
    localparam SUB = 4'd3;
    localparam ADD = 4'd4;
    localparam SRA = 4'd5;
    localparam ROR = 4'd6;
    localparam SRL = 4'd7;
    localparam SLT = 4'd8;
    localparam SLTU = 4'd9;
    localparam SEQ = 4'd10;
    localparam ROL = 4'd11;
    localparam XOR = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            AND: begin
                result = input1 & input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SLT: begin
            end
            SLTU: begin
            end
            SEQ: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule