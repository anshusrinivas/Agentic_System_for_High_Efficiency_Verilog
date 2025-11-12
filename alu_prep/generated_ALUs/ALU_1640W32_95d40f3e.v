`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: PASSB, SLTU, MUL, ROL, OR, XOR, SGE, SLL, SRL, SUB, AND, ADD, SGT
// Flags: carry, zero, sign

module ALU_1640W32_95d40f3e(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam PASSB = 4'd0;
    localparam SLTU = 4'd1;
    localparam MUL = 4'd2;
    localparam ROL = 4'd3;
    localparam OR = 4'd4;
    localparam XOR = 4'd5;
    localparam SGE = 4'd6;
    localparam SLL = 4'd7;
    localparam SRL = 4'd8;
    localparam SUB = 4'd9;
    localparam AND = 4'd10;
    localparam ADD = 4'd11;
    localparam SGT = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            PASSB: begin
                result = input2;
            end
            SLTU: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            OR: begin
                result = input1 | input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SGE: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            AND: begin
                result = input1 & input2;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SGT: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule