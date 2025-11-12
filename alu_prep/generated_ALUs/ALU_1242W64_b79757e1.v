`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SGT, ROL, MAX, XOR, NOR, SUB, SNE, NAND, SLTU, MIN, SLL
// Flags: carry, zero, sign

module ALU_1242W64_b79757e1(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SGT = 4'd0;
    localparam ROL = 4'd1;
    localparam MAX = 4'd2;
    localparam XOR = 4'd3;
    localparam NOR = 4'd4;
    localparam SUB = 4'd5;
    localparam SNE = 4'd6;
    localparam NAND = 4'd7;
    localparam SLTU = 4'd8;
    localparam MIN = 4'd9;
    localparam SLL = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SNE: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLTU: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule