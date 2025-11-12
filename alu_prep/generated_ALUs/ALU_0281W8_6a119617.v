`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: MAX, SRA, SRL, XOR, SUB, ADD, NOR, OR, ROL, SLL
// Flags: carry

module ALU_0281W8_6a119617(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam MAX = 4'd0;
    localparam SRA = 4'd1;
    localparam SRL = 4'd2;
    localparam XOR = 4'd3;
    localparam SUB = 4'd4;
    localparam ADD = 4'd5;
    localparam NOR = 4'd6;
    localparam OR = 4'd7;
    localparam ROL = 4'd8;
    localparam SLL = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            ADD: begin
                result = input1 + input2;
                
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            OR: begin
                result = input1 | input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 8'b0;
        endcase
    end

endmodule