`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SLL, SUB, AND, SRA, SEQ, SRL, XNOR, XOR, MIN, SLTU
// Flags: carry, zero, overflow

module ALU_0208W8_4a03032a(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SLL = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam SRA = 4'd3;
    localparam SEQ = 4'd4;
    localparam SRL = 4'd5;
    localparam XNOR = 4'd6;
    localparam XOR = 4'd7;
    localparam MIN = 4'd8;
    localparam SLTU = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLL: begin
                result = input1 << shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            AND: begin
                result = input1 & input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SEQ: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLTU: begin
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
    end

endmodule