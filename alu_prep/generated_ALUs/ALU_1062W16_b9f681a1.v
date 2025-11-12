`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SGT, XOR, NOR, SUB, NAND, ADD, SRA, SLL, AND, MIN, SLTU, ROR, SGE, XNOR
// Flags: carry

module ALU_1062W16_b9f681a1(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SGT = 4'd0;
    localparam XOR = 4'd1;
    localparam NOR = 4'd2;
    localparam SUB = 4'd3;
    localparam NAND = 4'd4;
    localparam ADD = 4'd5;
    localparam SRA = 4'd6;
    localparam SLL = 4'd7;
    localparam AND = 4'd8;
    localparam MIN = 4'd9;
    localparam SLTU = 4'd10;
    localparam ROR = 4'd11;
    localparam SGE = 4'd12;
    localparam XNOR = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SUB: begin
                result = input1 - input2;
                
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            AND: begin
                result = input1 & input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLTU: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SGE: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            default: result = 16'b0;
        endcase
    end

endmodule