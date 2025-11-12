`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SNE, MIN, OR, PASSB, SRA, SGT, XOR, MUL, DIV, ADD, XNOR, SUB, MAX, SGE
// Flags: carry, zero, overflow, sign

module ALU_0852W32_1f73f5ed(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SNE = 4'd0;
    localparam MIN = 4'd1;
    localparam OR = 4'd2;
    localparam PASSB = 4'd3;
    localparam SRA = 4'd4;
    localparam SGT = 4'd5;
    localparam XOR = 4'd6;
    localparam MUL = 4'd7;
    localparam DIV = 4'd8;
    localparam ADD = 4'd9;
    localparam XNOR = 4'd10;
    localparam SUB = 4'd11;
    localparam MAX = 4'd12;
    localparam SGE = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SNE: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            OR: begin
                result = input1 | input2;
            end
            PASSB: begin
                result = input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGT: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[31] != input2[31]) && (result[31] != input1[31]);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SGE: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule