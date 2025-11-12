`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SGT, OR, NAND, SLL, ROL, MUL, PASSB, SRA, SNE, MIN, SLT, SEQ
// Flags: carry, zero, overflow

module ALU_0402W32_7a740a55(
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
    localparam SGT = 4'd0;
    localparam OR = 4'd1;
    localparam NAND = 4'd2;
    localparam SLL = 4'd3;
    localparam ROL = 4'd4;
    localparam MUL = 4'd5;
    localparam PASSB = 4'd6;
    localparam SRA = 4'd7;
    localparam SNE = 4'd8;
    localparam MIN = 4'd9;
    localparam SLT = 4'd10;
    localparam SEQ = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            OR: begin
                result = input1 | input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            MUL: begin
                result = input1 * input2;
            end
            PASSB: begin
                result = input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SNE: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLT: begin
            end
            SEQ: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule