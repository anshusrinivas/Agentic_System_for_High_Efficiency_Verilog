`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRA, SGT, MIN, ROR, NOR, ADD, SEQ, SRL, SGE
// Flags: carry, zero, sign

module ALU_1811W16_65a882ad(
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
    localparam SRA = 4'd0;
    localparam SGT = 4'd1;
    localparam MIN = 4'd2;
    localparam ROR = 4'd3;
    localparam NOR = 4'd4;
    localparam ADD = 4'd5;
    localparam SEQ = 4'd6;
    localparam SRL = 4'd7;
    localparam SGE = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SEQ: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGE: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule