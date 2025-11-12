`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLL, SRL, SLTU, XOR, AND, PASSB, MUL, SEQ, MAX, NOR
// Flags: carry, zero, sign

module ALU_1341W16_69671ee5(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SLL = 4'd0;
    localparam SRL = 4'd1;
    localparam SLTU = 4'd2;
    localparam XOR = 4'd3;
    localparam AND = 4'd4;
    localparam PASSB = 4'd5;
    localparam MUL = 4'd6;
    localparam SEQ = 4'd7;
    localparam MAX = 4'd8;
    localparam NOR = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLL: begin
                result = input1 << shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SLTU: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            AND: begin
                result = input1 & input2;
            end
            PASSB: begin
                result = input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            SEQ: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule