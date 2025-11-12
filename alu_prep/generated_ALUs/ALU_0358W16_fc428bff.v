`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 16
// Operations: ROL, ROR, MAX, MIN, SUB, SEQ, SRA, OR, SNE, SLL
// Flags: carry

module ALU_0358W16_fc428bff(
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
    localparam SUB = 4'd4;
    localparam SEQ = 4'd5;
    localparam SRA = 4'd6;
    localparam OR = 4'd7;
    localparam SNE = 4'd8;
    localparam SLL = 4'd9;

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
            SUB: begin
                result = input1 - input2;
                
            end
            SEQ: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            SNE: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 16'b0;
        endcase
    end

endmodule