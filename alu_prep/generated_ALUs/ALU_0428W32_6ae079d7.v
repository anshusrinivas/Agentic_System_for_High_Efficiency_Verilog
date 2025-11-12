`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SLTU, MUL, ADD, ROL, SRL, MAX, NAND, DIV, ROR, SLT, SRA, MIN
// Flags: carry, zero, sign

module ALU_0428W32_6ae079d7(
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
    localparam SLTU = 4'd0;
    localparam MUL = 4'd1;
    localparam ADD = 4'd2;
    localparam ROL = 4'd3;
    localparam SRL = 4'd4;
    localparam MAX = 4'd5;
    localparam NAND = 4'd6;
    localparam DIV = 4'd7;
    localparam ROR = 4'd8;
    localparam SLT = 4'd9;
    localparam SRA = 4'd10;
    localparam MIN = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLTU: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SLT: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule