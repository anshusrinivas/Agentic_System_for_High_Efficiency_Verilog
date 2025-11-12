`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SRL, SGE, AND, XNOR, ADD, MUL, NAND, ROR, ROL, SLT
// Flags: carry, zero, overflow

module ALU_0138W32_1ad42ce0(
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
    localparam SGE = 4'd1;
    localparam AND = 4'd2;
    localparam XNOR = 4'd3;
    localparam ADD = 4'd4;
    localparam MUL = 4'd5;
    localparam NAND = 4'd6;
    localparam ROR = 4'd7;
    localparam ROL = 4'd8;
    localparam SLT = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGE: begin
            end
            AND: begin
                result = input1 & input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            MUL: begin
                result = input1 * input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule