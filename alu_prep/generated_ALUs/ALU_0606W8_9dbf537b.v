`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: DIV, SNE, MAX, NAND, OR, XNOR, MIN, SUB, PASSB
// Flags: carry, zero, overflow, sign

module ALU_0606W8_9dbf537b(
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
    localparam DIV = 4'd0;
    localparam SNE = 4'd1;
    localparam MAX = 4'd2;
    localparam NAND = 4'd3;
    localparam OR = 4'd4;
    localparam XNOR = 4'd5;
    localparam MIN = 4'd6;
    localparam SUB = 4'd7;
    localparam PASSB = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            SNE: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            OR: begin
                result = input1 | input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            PASSB: begin
                result = input2;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule