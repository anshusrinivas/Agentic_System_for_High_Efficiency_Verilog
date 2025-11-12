`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SEQ, PASSB, SGE, ROR, NOR, MAX, XOR, SUB
// Flags: carry, zero, overflow

module ALU_0068W16_64c5f463(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SEQ = 4'd0;
    localparam PASSB = 4'd1;
    localparam SGE = 4'd2;
    localparam ROR = 4'd3;
    localparam NOR = 4'd4;
    localparam MAX = 4'd5;
    localparam XOR = 4'd6;
    localparam SUB = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SEQ: begin
            end
            PASSB: begin
                result = input2;
            end
            SGE: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule