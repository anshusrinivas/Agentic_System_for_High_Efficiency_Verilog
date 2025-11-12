`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: MUL, SGT, XOR, AND, SGE, SLTU, SRL, SEQ, ADD, NAND
// Flags: carry, zero, sign

module ALU_1132W32_29ecffdf(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam MUL = 4'd0;
    localparam SGT = 4'd1;
    localparam XOR = 4'd2;
    localparam AND = 4'd3;
    localparam SGE = 4'd4;
    localparam SLTU = 4'd5;
    localparam SRL = 4'd6;
    localparam SEQ = 4'd7;
    localparam ADD = 4'd8;
    localparam NAND = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MUL: begin
                result = input1 * input2;
            end
            SGT: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SGE: begin
            end
            SLTU: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SEQ: begin
            end
            ADD: begin
                result = input1 + input2;
                
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule