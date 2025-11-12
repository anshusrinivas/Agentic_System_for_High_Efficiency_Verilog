`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: XOR, SNE, ROR, ROL, MIN, SLTU, SRL, PASSB, SLT, MAX, DIV, ADD
// Flags: carry, zero, sign

module ALU_1409W16_86fbd41e(
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
    localparam SNE = 4'd1;
    localparam ROR = 4'd2;
    localparam ROL = 4'd3;
    localparam MIN = 4'd4;
    localparam SLTU = 4'd5;
    localparam SRL = 4'd6;
    localparam PASSB = 4'd7;
    localparam SLT = 4'd8;
    localparam MAX = 4'd9;
    localparam DIV = 4'd10;
    localparam ADD = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            SNE: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLTU: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            SLT: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule