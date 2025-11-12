`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: NOR, SUB, SLL, ROL, OR, MAX, ROR, SEQ, ADD, XNOR
// Flags: carry

module ALU_1537W128_6f2bc25c(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam NOR = 4'd0;
    localparam SUB = 4'd1;
    localparam SLL = 4'd2;
    localparam ROL = 4'd3;
    localparam OR = 4'd4;
    localparam MAX = 4'd5;
    localparam ROR = 4'd6;
    localparam SEQ = 4'd7;
    localparam ADD = 4'd8;
    localparam XNOR = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            OR: begin
                result = input1 | input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SEQ: begin
            end
            ADD: begin
                result = input1 + input2;
                
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            default: result = 128'b0;
        endcase
    end

endmodule