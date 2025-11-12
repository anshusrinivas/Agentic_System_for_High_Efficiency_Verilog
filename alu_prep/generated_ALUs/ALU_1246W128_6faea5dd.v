`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SLT, OR, SNE, SRA, ROL, ADD, MIN, ROR, SEQ, SGE, NOR, SRL
// Flags: carry, zero, sign

module ALU_1246W128_6faea5dd(
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
    localparam SLT = 4'd0;
    localparam OR = 4'd1;
    localparam SNE = 4'd2;
    localparam SRA = 4'd3;
    localparam ROL = 4'd4;
    localparam ADD = 4'd5;
    localparam MIN = 4'd6;
    localparam ROR = 4'd7;
    localparam SEQ = 4'd8;
    localparam SGE = 4'd9;
    localparam NOR = 4'd10;
    localparam SRL = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            OR: begin
                result = input1 | input2;
            end
            SNE: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SEQ: begin
            end
            SGE: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule