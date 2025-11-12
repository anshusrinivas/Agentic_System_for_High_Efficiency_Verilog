`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 32
// Operations: ROL, ROR, MAX, MIN, PASSB, SRA, MUL, NAND, SLT
// Flags: carry, zero, overflow

module ALU_0113W32_9aa20e70(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [31:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire overFlowFlag
);

    function [31:0] rol;
        input [31:0] a;
        input [4:0] sh;
        begin
            rol = (a << sh) | (a >> (32-sh));
        end
    endfunction

    function [31:0] ror;
        input [31:0] a;
        input [4:0] sh;
        begin
            ror = (a >> sh) | (a << (32-sh));
        end
    endfunction

    // Operation codes
    localparam ROL = 4'd0;
    localparam ROR = 4'd1;
    localparam MAX = 4'd2;
    localparam MIN = 4'd3;
    localparam PASSB = 4'd4;
    localparam SRA = 4'd5;
    localparam MUL = 4'd6;
    localparam NAND = 4'd7;
    localparam SLT = 4'd8;

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
            PASSB: begin
                result = input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MUL: begin
                result = input1 * input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLT: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule