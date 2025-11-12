`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 32
// Operations: ROL, ROR, MAX, MIN, SGT, PASSB, SRA, SLT, SRL
// Flags: carry, zero, sign

module ALU_1424W32_821f643d(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [31:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire signFlag
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
    localparam SGT = 4'd4;
    localparam PASSB = 4'd5;
    localparam SRA = 4'd6;
    localparam SLT = 4'd7;
    localparam SRL = 4'd8;

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
            SGT: begin
            end
            PASSB: begin
                result = input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SLT: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule