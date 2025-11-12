`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: ADD, MAX, ROL, DIV, SLT, OR, NOR, SLTU, MIN, XNOR, NAND, SEQ
// Flags: carry

module ALU_0352W16_98340723(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam MAX = 4'd1;
    localparam ROL = 4'd2;
    localparam DIV = 4'd3;
    localparam SLT = 4'd4;
    localparam OR = 4'd5;
    localparam NOR = 4'd6;
    localparam SLTU = 4'd7;
    localparam MIN = 4'd8;
    localparam XNOR = 4'd9;
    localparam NAND = 4'd10;
    localparam SEQ = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SLT: begin
            end
            OR: begin
                result = input1 | input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLTU: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SEQ: begin
            end
            default: result = 16'b0;
        endcase
    end

endmodule