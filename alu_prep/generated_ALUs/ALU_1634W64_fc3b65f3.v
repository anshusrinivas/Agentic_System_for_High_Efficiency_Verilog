`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SLL, PASSB, SRL, SRA, ROL, OR, SGT, MIN, SEQ, ADD, DIV, MAX
// Flags: carry, zero, overflow

module ALU_1634W64_fc3b65f3(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SLL = 4'd0;
    localparam PASSB = 4'd1;
    localparam SRL = 4'd2;
    localparam SRA = 4'd3;
    localparam ROL = 4'd4;
    localparam OR = 4'd5;
    localparam SGT = 4'd6;
    localparam MIN = 4'd7;
    localparam SEQ = 4'd8;
    localparam ADD = 4'd9;
    localparam DIV = 4'd10;
    localparam MAX = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLL: begin
                result = input1 << shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            OR: begin
                result = input1 | input2;
            end
            SGT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SEQ: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 64'b0;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule