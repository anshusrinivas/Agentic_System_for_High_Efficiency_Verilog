`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 64
// Operations: ROL, ROR, MAX, MIN, MUL, AND, SEQ, NOR, SRA, SNE, PASSB, SLT
// Flags: carry, zero, overflow

module ALU_1453W64_48a1ba21(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [63:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire overFlowFlag
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
    localparam SEQ = 4'd6;
    localparam NOR = 4'd7;
    localparam SRA = 4'd8;
    localparam SNE = 4'd9;
    localparam PASSB = 4'd10;
    localparam SLT = 4'd11;

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
            SEQ: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SNE: begin
            end
            PASSB: begin
                result = input2;
            end
            SLT: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule