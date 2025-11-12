`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: OR, SRL, ADD, NOR, XOR, SRA, DIV, ROL, SLT, XNOR, SGT, SLTU
// Flags: carry, zero, overflow

module ALU_1707W32_ae974bc7(
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
    localparam OR = 4'd0;
    localparam SRL = 4'd1;
    localparam ADD = 4'd2;
    localparam NOR = 4'd3;
    localparam XOR = 4'd4;
    localparam SRA = 4'd5;
    localparam DIV = 4'd6;
    localparam ROL = 4'd7;
    localparam SLT = 4'd8;
    localparam XNOR = 4'd9;
    localparam SGT = 4'd10;
    localparam SLTU = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            OR: begin
                result = input1 | input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SGT: begin
            end
            SLTU: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule