`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: AND, ADD, SLTU, NOR, SRA, SLL, SUB, SGT, SLT, XNOR, XOR
// Flags: carry

module ALU_1033W64_660f4593(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam AND = 4'd0;
    localparam ADD = 4'd1;
    localparam SLTU = 4'd2;
    localparam NOR = 4'd3;
    localparam SRA = 4'd4;
    localparam SLL = 4'd5;
    localparam SUB = 4'd6;
    localparam SGT = 4'd7;
    localparam SLT = 4'd8;
    localparam XNOR = 4'd9;
    localparam XOR = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            AND: begin
                result = input1 & input2;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SLTU: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SGT: begin
            end
            SLT: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            default: result = 64'b0;
        endcase
    end

endmodule