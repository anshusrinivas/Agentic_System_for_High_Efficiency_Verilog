`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 128
// Operations: ROL, ROR, MAX, MIN, SEQ, XNOR, NOR, SLL
// Flags: carry, zero, overflow, sign

module ALU_1381W128_84f1a902(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [127:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire overFlowFlag
    ,output wire signFlag
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
    localparam SEQ = 4'd4;
    localparam XNOR = 4'd5;
    localparam NOR = 4'd6;
    localparam SLL = 4'd7;

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
            SEQ: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule