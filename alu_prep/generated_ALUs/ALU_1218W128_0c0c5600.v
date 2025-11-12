`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SUB, MIN, ROL, SEQ, MAX, SRA, SNE, XNOR, ADD, NAND
// Flags: carry, zero, overflow

module ALU_1218W128_0c0c5600(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SUB = 4'd0;
    localparam MIN = 4'd1;
    localparam ROL = 4'd2;
    localparam SEQ = 4'd3;
    localparam MAX = 4'd4;
    localparam SRA = 4'd5;
    localparam SNE = 4'd6;
    localparam XNOR = 4'd7;
    localparam ADD = 4'd8;
    localparam NAND = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SEQ: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SNE: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule