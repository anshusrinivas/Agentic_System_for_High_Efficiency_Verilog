`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: PASSB, ROR, NOR, SNE, ROL, DIV, SGT, SUB, XNOR, NAND, SRL
// Flags: carry, zero, sign

module ALU_0003W16_707dc576(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);
    function [15:0] rol;
        input [15:0] a;
        input [4:0] sh;
        begin
            rol = (a << sh) | (a >> (16-sh));
        end
    endfunction

    function [15:0] ror;
        input [15:0] a;
        input [4:0] sh;
        begin
            ror = (a >> sh) | (a << (16-sh));
        end
    endfunction
    // Operation codes
    localparam PASSB = 4'd0;
    localparam ROR = 4'd1;
    localparam NOR = 4'd2;
    localparam SNE = 4'd3;
    localparam ROL = 4'd4;
    localparam DIV = 4'd5;
    localparam SGT = 4'd6;
    localparam SUB = 4'd7;
    localparam XNOR = 4'd8;
    localparam NAND = 4'd9;
    localparam SRL = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            PASSB: begin
                result = input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SNE: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SGT: begin
            end
            SUB: begin
                result = input1 - input2;
                
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule