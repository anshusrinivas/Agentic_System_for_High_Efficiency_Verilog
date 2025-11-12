`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SNE, ADD, SGE, MIN, SRL, MAX, SUB, NOR
// Flags: carry, zero, overflow, sign

module ALU_1826W16_5dbff275(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SNE = 4'd0;
    localparam ADD = 4'd1;
    localparam SGE = 4'd2;
    localparam MIN = 4'd3;
    localparam SRL = 4'd4;
    localparam MAX = 4'd5;
    localparam SUB = 4'd6;
    localparam NOR = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SNE: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            SGE: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule