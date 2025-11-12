`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SLL, SRA, PASSB, SUB, SGE, XNOR, SLT, SGT, MIN, AND
// Flags: carry, zero, overflow, sign

module ALU_1215W8_10f293dd(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SLL = 4'd0;
    localparam SRA = 4'd1;
    localparam PASSB = 4'd2;
    localparam SUB = 4'd3;
    localparam SGE = 4'd4;
    localparam XNOR = 4'd5;
    localparam SLT = 4'd6;
    localparam SGT = 4'd7;
    localparam MIN = 4'd8;
    localparam AND = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLL: begin
                result = input1 << shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            SGE: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SLT: begin
            end
            SGT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            AND: begin
                result = input1 & input2;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule