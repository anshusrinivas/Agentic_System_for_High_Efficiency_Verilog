`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: MAX, PASSB, SLT, NOR, DIV, SGT, SGE, ROR, NAND, SNE, SLTU, MUL, XOR, ROL
// Flags: carry, zero, overflow, sign

module ALU_0243W16_e0d6b730(
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
    localparam MAX = 4'd0;
    localparam PASSB = 4'd1;
    localparam SLT = 4'd2;
    localparam NOR = 4'd3;
    localparam DIV = 4'd4;
    localparam SGT = 4'd5;
    localparam SGE = 4'd6;
    localparam ROR = 4'd7;
    localparam NAND = 4'd8;
    localparam SNE = 4'd9;
    localparam SLTU = 4'd10;
    localparam MUL = 4'd11;
    localparam XOR = 4'd12;
    localparam ROL = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            PASSB: begin
                result = input2;
            end
            SLT: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SGT: begin
            end
            SGE: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SNE: begin
            end
            SLTU: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule