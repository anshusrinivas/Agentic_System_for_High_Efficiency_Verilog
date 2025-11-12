`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: PASSB, SUB, SRA, NAND, AND, SLT, SLL, OR, SGE, SNE
// Flags: carry, zero, sign

module ALU_1594W128_cb9eb2ef(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam PASSB = 4'd0;
    localparam SUB = 4'd1;
    localparam SRA = 4'd2;
    localparam NAND = 4'd3;
    localparam AND = 4'd4;
    localparam SLT = 4'd5;
    localparam SLL = 4'd6;
    localparam OR = 4'd7;
    localparam SGE = 4'd8;
    localparam SNE = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            PASSB: begin
                result = input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            AND: begin
                result = input1 & input2;
            end
            SLT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            SGE: begin
            end
            SNE: begin
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule