`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: ADD, SLL, SGT, PASSB, MUL, NAND, SGE, SEQ, SRA
// Flags: carry, zero, overflow

module ALU_1778W8_e7653ea3(
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
    localparam ADD = 4'd0;
    localparam SLL = 4'd1;
    localparam SGT = 4'd2;
    localparam PASSB = 4'd3;
    localparam MUL = 4'd4;
    localparam NAND = 4'd5;
    localparam SGE = 4'd6;
    localparam SEQ = 4'd7;
    localparam SRA = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SGT: begin
            end
            PASSB: begin
                result = input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SGE: begin
            end
            SEQ: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
    end

endmodule