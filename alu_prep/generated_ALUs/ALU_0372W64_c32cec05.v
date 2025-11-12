`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 64
// Operations: ROL, ROR, MAX, MIN, ADD, SGT, SLT, SRA, NOR, SLL, XNOR
// Flags: carry, zero, overflow

module ALU_0372W64_c32cec05(
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
    localparam ADD = 4'd4;
    localparam SGT = 4'd5;
    localparam SLT = 4'd6;
    localparam SRA = 4'd7;
    localparam NOR = 4'd8;
    localparam SLL = 4'd9;
    localparam XNOR = 4'd10;

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
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            SGT: begin
            end
            SLT: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule