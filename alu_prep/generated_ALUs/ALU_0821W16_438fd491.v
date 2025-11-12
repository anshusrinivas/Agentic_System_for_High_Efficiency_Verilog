`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: NOR, MUL, SUB, MAX, SRA, SGE, NAND, SLTU, ROR, SNE
// Flags: carry, zero, sign

module ALU_0821W16_438fd491(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam NOR = 4'd0;
    localparam MUL = 4'd1;
    localparam SUB = 4'd2;
    localparam MAX = 4'd3;
    localparam SRA = 4'd4;
    localparam SGE = 4'd5;
    localparam NAND = 4'd6;
    localparam SLTU = 4'd7;
    localparam ROR = 4'd8;
    localparam SNE = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGE: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLTU: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SNE: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule