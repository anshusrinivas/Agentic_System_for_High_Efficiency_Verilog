`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: MIN, PASSB, SRA, SGE, SLTU, SGT, SEQ, ADD, ROL, XOR, ROR, NOR, SUB, OR
// Flags: carry

module ALU_1030W16_5d8438b0(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam MIN = 4'd0;
    localparam PASSB = 4'd1;
    localparam SRA = 4'd2;
    localparam SGE = 4'd3;
    localparam SLTU = 4'd4;
    localparam SGT = 4'd5;
    localparam SEQ = 4'd6;
    localparam ADD = 4'd7;
    localparam ROL = 4'd8;
    localparam XOR = 4'd9;
    localparam ROR = 4'd10;
    localparam NOR = 4'd11;
    localparam SUB = 4'd12;
    localparam OR = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            PASSB: begin
                result = input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGE: begin
            end
            SLTU: begin
            end
            SGT: begin
            end
            SEQ: begin
            end
            ADD: begin
                result = input1 + input2;
                
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SUB: begin
                result = input1 - input2;
                
            end
            OR: begin
                result = input1 | input2;
            end
            default: result = 16'b0;
        endcase
    end

endmodule