`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: NOR, MUL, DIV, PASSB, OR, SGE, SRA, MIN, NAND, SLTU
// Flags: carry, zero, overflow

module ALU_0201W8_09aaed22(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam NOR = 4'd0;
    localparam MUL = 4'd1;
    localparam DIV = 4'd2;
    localparam PASSB = 4'd3;
    localparam OR = 4'd4;
    localparam SGE = 4'd5;
    localparam SRA = 4'd6;
    localparam MIN = 4'd7;
    localparam NAND = 4'd8;
    localparam SLTU = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            PASSB: begin
                result = input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SGE: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLTU: begin
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
    end

endmodule