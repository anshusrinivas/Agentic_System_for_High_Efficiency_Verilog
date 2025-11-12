`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SGT, PASSB, SEQ, MUL, SUB, ADD, ROR, SLTU, SGE, SRA, SLT, ROL
// Flags: carry, zero, sign

module ALU_1386W128_98499690(
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
    localparam SGT = 4'd0;
    localparam PASSB = 4'd1;
    localparam SEQ = 4'd2;
    localparam MUL = 4'd3;
    localparam SUB = 4'd4;
    localparam ADD = 4'd5;
    localparam ROR = 4'd6;
    localparam SLTU = 4'd7;
    localparam SGE = 4'd8;
    localparam SRA = 4'd9;
    localparam SLT = 4'd10;
    localparam ROL = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            PASSB: begin
                result = input2;
            end
            SEQ: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            ADD: begin
                result = input1 + input2;
                
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SLTU: begin
            end
            SGE: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SLT: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule