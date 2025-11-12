`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: OR, ADD, MIN, AND, SRL, SUB, SGE, SNE, PASSB
// Flags: carry, zero, sign

module ALU_0697W32_22ad1b74(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam OR = 4'd0;
    localparam ADD = 4'd1;
    localparam MIN = 4'd2;
    localparam AND = 4'd3;
    localparam SRL = 4'd4;
    localparam SUB = 4'd5;
    localparam SGE = 4'd6;
    localparam SNE = 4'd7;
    localparam PASSB = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            OR: begin
                result = input1 | input2;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SGE: begin
            end
            SNE: begin
            end
            PASSB: begin
                result = input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule