`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRL, ROL, SLT, SLL, DIV, AND, XNOR, ROR, XOR, NOR, SGT
// Flags: carry, zero, sign

module ALU_1433W16_b5d8815b(
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
    localparam SRL = 4'd0;
    localparam ROL = 4'd1;
    localparam SLT = 4'd2;
    localparam SLL = 4'd3;
    localparam DIV = 4'd4;
    localparam AND = 4'd5;
    localparam XNOR = 4'd6;
    localparam ROR = 4'd7;
    localparam XOR = 4'd8;
    localparam NOR = 4'd9;
    localparam SGT = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            AND: begin
                result = input1 & input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SGT: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule