`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: ADD, AND, OR, SLL, MAX, PASSB, SRL, MUL, ROR
// Flags: carry

module ALU_0744W64_d246dc07(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam AND = 4'd1;
    localparam OR = 4'd2;
    localparam SLL = 4'd3;
    localparam MAX = 4'd4;
    localparam PASSB = 4'd5;
    localparam SRL = 4'd6;
    localparam MUL = 4'd7;
    localparam ROR = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                
            end
            AND: begin
                result = input1 & input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            PASSB: begin
                result = input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MUL: begin
                result = input1 * input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            default: result = 64'b0;
        endcase
    end

endmodule