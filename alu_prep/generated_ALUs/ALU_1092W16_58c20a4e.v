`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: NOR, OR, XNOR, SLTU, SGE, NAND, SNE, PASSB, SUB, SEQ
// Flags: carry, zero, overflow

module ALU_1092W16_58c20a4e(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam NOR = 4'd0;
    localparam OR = 4'd1;
    localparam XNOR = 4'd2;
    localparam SLTU = 4'd3;
    localparam SGE = 4'd4;
    localparam NAND = 4'd5;
    localparam SNE = 4'd6;
    localparam PASSB = 4'd7;
    localparam SUB = 4'd8;
    localparam SEQ = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            OR: begin
                result = input1 | input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SLTU: begin
            end
            SGE: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SNE: begin
            end
            PASSB: begin
                result = input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            SEQ: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule