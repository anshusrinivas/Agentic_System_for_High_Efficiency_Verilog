`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SUB, ADD, AND, MAX, SLT, SLTU
// Flags: carry, zero, overflow

module ALU_1560W64_b1803fc2(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SUB = 4'd0;
    localparam ADD = 4'd1;
    localparam AND = 4'd2;
    localparam MAX = 4'd3;
    localparam SLT = 4'd4;
    localparam SLTU = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SUB: begin
                result = input1 - input2;
                overflow = (input1[63] != input2[63]) && (result[63] != input1[63]);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            AND: begin
                result = input1 & input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SLT: begin
            end
            SLTU: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule