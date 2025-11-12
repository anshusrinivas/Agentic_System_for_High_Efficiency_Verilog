`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRA, OR, SGT, SLTU, ROR, SGE
// Flags: carry, zero, overflow

module ALU_0298W16_d2fafa1f(
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
    localparam SRA = 4'd0;
    localparam OR = 4'd1;
    localparam SGT = 4'd2;
    localparam SLTU = 4'd3;
    localparam ROR = 4'd4;
    localparam SGE = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            SGT: begin
            end
            SLTU: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SGE: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule