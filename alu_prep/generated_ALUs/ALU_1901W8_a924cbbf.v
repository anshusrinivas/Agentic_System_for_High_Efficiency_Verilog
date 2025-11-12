`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: ADD, ROL, SRL, XOR, SLL, OR, SEQ, ROR, SLT
// Flags: carry, zero, sign

module ALU_1901W8_a924cbbf(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam ROL = 4'd1;
    localparam SRL = 4'd2;
    localparam XOR = 4'd3;
    localparam SLL = 4'd4;
    localparam OR = 4'd5;
    localparam SEQ = 4'd6;
    localparam ROR = 4'd7;
    localparam SLT = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            SEQ: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SLT: begin
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule