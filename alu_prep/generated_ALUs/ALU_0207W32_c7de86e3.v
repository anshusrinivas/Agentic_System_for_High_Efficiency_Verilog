`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SRL, ROR, SEQ, SUB, SGE, DIV, SRA, MAX, MUL, AND
// Flags: carry, zero, overflow

module ALU_0207W32_c7de86e3(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SRL = 4'd0;
    localparam ROR = 4'd1;
    localparam SEQ = 4'd2;
    localparam SUB = 4'd3;
    localparam SGE = 4'd4;
    localparam DIV = 4'd5;
    localparam SRA = 4'd6;
    localparam MAX = 4'd7;
    localparam MUL = 4'd8;
    localparam AND = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SEQ: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[31] != input2[31]) && (result[31] != input1[31]);
            end
            SGE: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            AND: begin
                result = input1 & input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule