`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SRA, ROL, ADD, SEQ, ROR, XOR, NOR, PASSB, AND, MUL, OR, SLT, SLTU, DIV
// Flags: carry, zero, sign

module ALU_1425W128_324d5da2(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SRA = 4'd0;
    localparam ROL = 4'd1;
    localparam ADD = 4'd2;
    localparam SEQ = 4'd3;
    localparam ROR = 4'd4;
    localparam XOR = 4'd5;
    localparam NOR = 4'd6;
    localparam PASSB = 4'd7;
    localparam AND = 4'd8;
    localparam MUL = 4'd9;
    localparam OR = 4'd10;
    localparam SLT = 4'd11;
    localparam SLTU = 4'd12;
    localparam DIV = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SEQ: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            PASSB: begin
                result = input2;
            end
            AND: begin
                result = input1 & input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SLT: begin
            end
            SLTU: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule