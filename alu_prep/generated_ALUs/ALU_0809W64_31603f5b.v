`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 64
// Operations: ROL, ROR, MAX, MIN, MUL, AND, SRA, SRL, NAND, SUB, OR
// Flags: carry, zero, sign

module ALU_0809W64_31603f5b(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [63:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire signFlag
);

    function [63:0] rol;
        input [63:0] a;
        input [4:0] sh;
        begin
            rol = (a << sh) | (a >> (64-sh));
        end
    endfunction

    function [63:0] ror;
        input [63:0] a;
        input [4:0] sh;
        begin
            ror = (a >> sh) | (a << (64-sh));
        end
    endfunction

    // Operation codes
    localparam ROL = 4'd0;
    localparam ROR = 4'd1;
    localparam MAX = 4'd2;
    localparam MIN = 4'd3;
    localparam MUL = 4'd4;
    localparam AND = 4'd5;
    localparam SRA = 4'd6;
    localparam SRL = 4'd7;
    localparam NAND = 4'd8;
    localparam SUB = 4'd9;
    localparam OR = 4'd10;

    // Internal signals
    wire [64:0] sum = (opcode == SUB) ? 
                             {1'b0, input1} - {1'b0, input2} : 
                             {1'b0, input1} + {1'b0, input2};

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROL: begin
                result = rol(input1, shiftValue);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SUB: begin
                result = input1 - input2;
                
            end
            OR: begin
                result = input1 | input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule