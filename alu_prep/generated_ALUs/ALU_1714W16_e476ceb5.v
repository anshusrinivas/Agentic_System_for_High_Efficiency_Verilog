`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLT, SEQ, MUL, SRA, OR, NOR, PASSB
// Flags: carry, zero, overflow, sign

module ALU_1714W16_e476ceb5(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SLT = 4'd0;
    localparam SEQ = 4'd1;
    localparam MUL = 4'd2;
    localparam SRA = 4'd3;
    localparam OR = 4'd4;
    localparam NOR = 4'd5;
    localparam PASSB = 4'd6;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            SEQ: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            PASSB: begin
                result = input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule