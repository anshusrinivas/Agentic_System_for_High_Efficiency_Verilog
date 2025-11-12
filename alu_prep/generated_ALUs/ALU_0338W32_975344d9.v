`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: OR, SLL, SRA, SRL, SGT, SEQ, MIN, MUL, SUB, ROR
// Flags: carry

module ALU_0338W32_975344d9(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam OR = 4'd0;
    localparam SLL = 4'd1;
    localparam SRA = 4'd2;
    localparam SRL = 4'd3;
    localparam SGT = 4'd4;
    localparam SEQ = 4'd5;
    localparam MIN = 4'd6;
    localparam MUL = 4'd7;
    localparam SUB = 4'd8;
    localparam ROR = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            OR: begin
                result = input1 | input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGT: begin
            end
            SEQ: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            default: result = 32'b0;
        endcase
    end

endmodule