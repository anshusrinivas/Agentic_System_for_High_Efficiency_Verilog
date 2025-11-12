`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRA, SLL, DIV, SUB, MUL, XNOR, OR, SGT, SLT, ROL, NAND, ADD
// Flags: carry, zero, sign

module ALU_1416W16_c146c502(
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
    localparam SRA = 4'd0;
    localparam SLL = 4'd1;
    localparam DIV = 4'd2;
    localparam SUB = 4'd3;
    localparam MUL = 4'd4;
    localparam XNOR = 4'd5;
    localparam OR = 4'd6;
    localparam SGT = 4'd7;
    localparam SLT = 4'd8;
    localparam ROL = 4'd9;
    localparam NAND = 4'd10;
    localparam ADD = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            MUL: begin
                result = input1 * input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            OR: begin
                result = input1 | input2;
            end
            SGT: begin
            end
            SLT: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule