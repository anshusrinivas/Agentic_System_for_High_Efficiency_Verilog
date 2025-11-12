`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SGT, NOR, SRA, SRL, SLT, MAX, MIN, XNOR, DIV, AND
// Flags: carry, zero, overflow, sign

module ALU_1291W8_2a879587(
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
    localparam SGT = 4'd0;
    localparam NOR = 4'd1;
    localparam SRA = 4'd2;
    localparam SRL = 4'd3;
    localparam SLT = 4'd4;
    localparam MAX = 4'd5;
    localparam MIN = 4'd6;
    localparam XNOR = 4'd7;
    localparam DIV = 4'd8;
    localparam AND = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SLT: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
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