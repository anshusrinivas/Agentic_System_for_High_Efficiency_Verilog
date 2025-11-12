`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 16
// Operations: ROL, ROR, MAX, MIN, NOR, SEQ, AND, XOR, OR
// Flags: carry

module ALU_1593W16_ccf0e7d4(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [15:0] result
    ,output wire carryFlag
);

    function [15:0] rol;
        input [15:0] a;
        input [4:0] sh;
        begin
            rol = (a << sh) | (a >> (16-sh));
        end
    endfunction

    function [15:0] ror;
        input [15:0] a;
        input [4:0] sh;
        begin
            ror = (a >> sh) | (a << (16-sh));
        end
    endfunction

    // Operation codes
    localparam ROL = 4'd0;
    localparam ROR = 4'd1;
    localparam MAX = 4'd2;
    localparam MIN = 4'd3;
    localparam NOR = 4'd4;
    localparam SEQ = 4'd5;
    localparam AND = 4'd6;
    localparam XOR = 4'd7;
    localparam OR = 4'd8;

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
            NOR: begin
                result = ~(input1 | input2);
            end
            SEQ: begin
            end
            AND: begin
                result = input1 & input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            OR: begin
                result = input1 | input2;
            end
            default: result = 16'b0;
        endcase
    end

endmodule