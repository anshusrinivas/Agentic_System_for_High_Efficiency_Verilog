`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRA, MAX, SUB, OR, SGE, SEQ, ROL, AND, XNOR, MIN, NAND, ADD, DIV
// Flags: carry, zero, sign

module ALU_0544W16_f3d7ea50(
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
    localparam MAX = 4'd1;
    localparam SUB = 4'd2;
    localparam OR = 4'd3;
    localparam SGE = 4'd4;
    localparam SEQ = 4'd5;
    localparam ROL = 4'd6;
    localparam AND = 4'd7;
    localparam XNOR = 4'd8;
    localparam MIN = 4'd9;
    localparam NAND = 4'd10;
    localparam ADD = 4'd11;
    localparam DIV = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            OR: begin
                result = input1 | input2;
            end
            SGE: begin
            end
            SEQ: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            AND: begin
                result = input1 & input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule