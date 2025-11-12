`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: ADD, DIV, SLL, SLT, SGE, SUB, SRA, XOR, MUL, SLTU, MIN, SGT, PASSB
// Flags: carry, zero, overflow, sign

module ALU_0036W32_784eb305(
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
    localparam ADD = 4'd0;
    localparam DIV = 4'd1;
    localparam SLL = 4'd2;
    localparam SLT = 4'd3;
    localparam SGE = 4'd4;
    localparam SUB = 4'd5;
    localparam SRA = 4'd6;
    localparam XOR = 4'd7;
    localparam MUL = 4'd8;
    localparam SLTU = 4'd9;
    localparam MIN = 4'd10;
    localparam SGT = 4'd11;
    localparam PASSB = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SLT: begin
            end
            SGE: begin
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[31] != input2[31]) && (result[31] != input1[31]);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            SLTU: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SGT: begin
            end
            PASSB: begin
                result = input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule