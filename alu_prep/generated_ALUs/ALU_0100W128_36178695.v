`timescale 1ns / 1ps

// Generated ALU Module
// Style: FUNCTION
// Bit width: 128
// Operations: ROL, ROR, MAX, MIN, SNE, PASSB, XNOR, SLTU, OR, SRL
// Flags: carry, zero, sign

module ALU_0100W128_36178695(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [127:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire signFlag
);

    function [127:0] rol;
        input [127:0] a;
        input [4:0] sh;
        begin
            rol = (a << sh) | (a >> (128-sh));
        end
    endfunction

    function [127:0] ror;
        input [127:0] a;
        input [4:0] sh;
        begin
            ror = (a >> sh) | (a << (128-sh));
        end
    endfunction

    // Operation codes
    localparam ROL = 4'd0;
    localparam ROR = 4'd1;
    localparam MAX = 4'd2;
    localparam MIN = 4'd3;
    localparam SNE = 4'd4;
    localparam PASSB = 4'd5;
    localparam XNOR = 4'd6;
    localparam SLTU = 4'd7;
    localparam OR = 4'd8;
    localparam SRL = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROL: begin
                result = rol(input1, shiftValue);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SNE: begin
            end
            PASSB: begin
                result = input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SLTU: begin
            end
            OR: begin
                result = input1 | input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule