`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 128
// Operations: ROL, ROR, MAX, MIN, DIV, OR, SLL, XNOR, SRA, SGT, MUL
// Flags: carry

module ALU_1905W128_6fe1faeb(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [127:0] result
    ,output wire carryFlag
);

    function [127:0] rol;
        input [127:0] a;
        input [4:0] sh;
        begin
            rol = (a << sh) | (a >> (128-sh));
        end
    endfunction

    function [127:0] ror;
        input [127:0] a;
        input [4:0] sh;
        begin
            ror = (a >> sh) | (a << (128-sh));
        end
    endfunction

    // Operation codes
    localparam ROL = 4'd0;
    localparam ROR = 4'd1;
    localparam MAX = 4'd2;
    localparam MIN = 4'd3;
    localparam DIV = 4'd4;
    localparam OR = 4'd5;
    localparam SLL = 4'd6;
    localparam XNOR = 4'd7;
    localparam SRA = 4'd8;
    localparam SGT = 4'd9;
    localparam MUL = 4'd10;

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
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            OR: begin
                result = input1 | input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGT: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 128'b0;
        endcase
    end

endmodule