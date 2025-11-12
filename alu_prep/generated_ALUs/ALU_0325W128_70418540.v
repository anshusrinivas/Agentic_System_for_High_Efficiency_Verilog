`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SRL, MIN, SEQ, SGT, ADD, AND, MAX, ROL, XNOR, XOR, SNE, NAND, SLTU
// Flags: carry, zero, overflow

module ALU_0325W128_70418540(
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
    localparam SRL = 4'd0;
    localparam MIN = 4'd1;
    localparam SEQ = 4'd2;
    localparam SGT = 4'd3;
    localparam ADD = 4'd4;
    localparam AND = 4'd5;
    localparam MAX = 4'd6;
    localparam ROL = 4'd7;
    localparam XNOR = 4'd8;
    localparam XOR = 4'd9;
    localparam SNE = 4'd10;
    localparam NAND = 4'd11;
    localparam SLTU = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SEQ: begin
            end
            SGT: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            AND: begin
                result = input1 & input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SNE: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLTU: begin
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule