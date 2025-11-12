`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: XOR, SRL, SGT, XNOR, AND, SUB, OR, SNE, DIV, SLT
// Flags: carry, zero, sign

module ALU_0534W16_136baf93(
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
    localparam SRL = 4'd1;
    localparam SGT = 4'd2;
    localparam XNOR = 4'd3;
    localparam AND = 4'd4;
    localparam SUB = 4'd5;
    localparam OR = 4'd6;
    localparam SNE = 4'd7;
    localparam DIV = 4'd8;
    localparam SLT = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SGT: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            AND: begin
                result = input1 & input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            OR: begin
                result = input1 | input2;
            end
            SNE: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SLT: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule