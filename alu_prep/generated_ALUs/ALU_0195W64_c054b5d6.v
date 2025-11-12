`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SRL, XOR, ADD, MAX, OR, AND, SRA, SEQ, ROR, DIV
// Flags: carry

module ALU_0195W64_c054b5d6(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SRL = 4'd0;
    localparam XOR = 4'd1;
    localparam ADD = 4'd2;
    localparam MAX = 4'd3;
    localparam OR = 4'd4;
    localparam AND = 4'd5;
    localparam SRA = 4'd6;
    localparam SEQ = 4'd7;
    localparam ROR = 4'd8;
    localparam DIV = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            OR: begin
                result = input1 | input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SEQ: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 64'b0;
            end
            default: result = 64'b0;
        endcase
    end

endmodule