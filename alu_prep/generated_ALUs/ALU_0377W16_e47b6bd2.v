`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 16
// Operations: ROL, ROR, MAX, MIN, SRA, SUB, XNOR, NOR, OR, DIV, SLL
// Flags: carry, zero, overflow

module ALU_0377W16_e47b6bd2(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [15:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire overFlowFlag
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
    localparam SRA = 4'd4;
    localparam SUB = 4'd5;
    localparam XNOR = 4'd6;
    localparam NOR = 4'd7;
    localparam OR = 4'd8;
    localparam DIV = 4'd9;
    localparam SLL = 4'd10;

    // Internal signals
    wire [16:0] sum = (opcode == SUB) ? 
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
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            OR: begin
                result = input1 | input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule