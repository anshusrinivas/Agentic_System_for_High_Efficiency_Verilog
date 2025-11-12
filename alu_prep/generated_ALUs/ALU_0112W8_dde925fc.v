`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 8
// Operations: ROL, ROR, MAX, MIN, SLL, PASSB, DIV, NAND, MUL, OR, SEQ, SGT
// Flags: carry, zero, overflow, sign

module ALU_0112W8_dde925fc(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [7:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire overFlowFlag
    ,output wire signFlag
);

    function [7:0] rol;
        input [7:0] a;
        input [4:0] sh;
        begin
            rol = (a << sh) | (a >> (8-sh));
        end
    endfunction

    function [7:0] ror;
        input [7:0] a;
        input [4:0] sh;
        begin
            ror = (a >> sh) | (a << (8-sh));
        end
    endfunction

    // Operation codes
    localparam ROL = 4'd0;
    localparam ROR = 4'd1;
    localparam MAX = 4'd2;
    localparam MIN = 4'd3;
    localparam SLL = 4'd4;
    localparam PASSB = 4'd5;
    localparam DIV = 4'd6;
    localparam NAND = 4'd7;
    localparam MUL = 4'd8;
    localparam OR = 4'd9;
    localparam SEQ = 4'd10;
    localparam SGT = 4'd11;

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
            SLL: begin
                result = input1 << shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SEQ: begin
            end
            SGT: begin
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule