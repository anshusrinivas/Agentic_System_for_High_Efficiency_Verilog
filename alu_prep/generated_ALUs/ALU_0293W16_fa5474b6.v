`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SGT, PASSB, SLTU, AND, SNE, ROR, SUB, SEQ, ROL, NOR, SLL, SRL
// Flags: carry, zero, sign

module ALU_0293W16_fa5474b6(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SGT = 4'd0;
    localparam PASSB = 4'd1;
    localparam SLTU = 4'd2;
    localparam AND = 4'd3;
    localparam SNE = 4'd4;
    localparam ROR = 4'd5;
    localparam SUB = 4'd6;
    localparam SEQ = 4'd7;
    localparam ROL = 4'd8;
    localparam NOR = 4'd9;
    localparam SLL = 4'd10;
    localparam SRL = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            PASSB: begin
                result = input2;
            end
            SLTU: begin
            end
            AND: begin
                result = input1 & input2;
            end
            SNE: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SEQ: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule