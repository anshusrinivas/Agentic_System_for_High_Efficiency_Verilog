`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: NOR, XNOR, SLTU, OR, SUB, SRA, ADD, MUL, DIV, SRL, SNE, ROL, SLT, NAND
// Flags: carry, zero, overflow, sign

module ALU_0720W32_ee89966e(
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
    localparam NOR = 4'd0;
    localparam XNOR = 4'd1;
    localparam SLTU = 4'd2;
    localparam OR = 4'd3;
    localparam SUB = 4'd4;
    localparam SRA = 4'd5;
    localparam ADD = 4'd6;
    localparam MUL = 4'd7;
    localparam DIV = 4'd8;
    localparam SRL = 4'd9;
    localparam SNE = 4'd10;
    localparam ROL = 4'd11;
    localparam SLT = 4'd12;
    localparam NAND = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SLTU: begin
            end
            OR: begin
                result = input1 | input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[31] != input2[31]) && (result[31] != input1[31]);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            MUL: begin
                result = input1 * input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SNE: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
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