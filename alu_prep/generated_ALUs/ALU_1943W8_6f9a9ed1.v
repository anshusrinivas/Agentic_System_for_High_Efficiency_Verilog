`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SNE, XNOR, OR, SLTU, NOR, ROR, MIN, DIV, SLT, SRL, SEQ, MUL, SRA, SUB
// Flags: carry, zero, overflow, sign

module ALU_1943W8_6f9a9ed1(
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
    localparam SNE = 4'd0;
    localparam XNOR = 4'd1;
    localparam OR = 4'd2;
    localparam SLTU = 4'd3;
    localparam NOR = 4'd4;
    localparam ROR = 4'd5;
    localparam MIN = 4'd6;
    localparam DIV = 4'd7;
    localparam SLT = 4'd8;
    localparam SRL = 4'd9;
    localparam SEQ = 4'd10;
    localparam MUL = 4'd11;
    localparam SRA = 4'd12;
    localparam SUB = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SNE: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            OR: begin
                result = input1 | input2;
            end
            SLTU: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            SLT: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SEQ: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
        signFlag = result[7];
    end

endmodule