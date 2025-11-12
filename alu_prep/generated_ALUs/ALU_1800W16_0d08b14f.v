`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: XOR, SRA, PASSB, SLL, OR, SRL, SGE
// Flags: carry, zero, sign

module ALU_1800W16_0d08b14f(
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
    localparam XOR = 4'd0;
    localparam SRA = 4'd1;
    localparam PASSB = 4'd2;
    localparam SLL = 4'd3;
    localparam OR = 4'd4;
    localparam SRL = 4'd5;
    localparam SGE = 4'd6;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            OR: begin
                result = input1 | input2;
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