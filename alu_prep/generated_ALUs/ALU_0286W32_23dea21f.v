`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: DIV, ROL, SLT, SLL, SRA, SGT, NOR, SRL, XOR, SNE, ADD, SGE
// Flags: carry, zero, overflow

module ALU_0286W32_23dea21f(
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
    localparam DIV = 4'd0;
    localparam ROL = 4'd1;
    localparam SLT = 4'd2;
    localparam SLL = 4'd3;
    localparam SRA = 4'd4;
    localparam SGT = 4'd5;
    localparam NOR = 4'd6;
    localparam SRL = 4'd7;
    localparam XOR = 4'd8;
    localparam SNE = 4'd9;
    localparam ADD = 4'd10;
    localparam SGE = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGT: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SNE: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            SGE: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule