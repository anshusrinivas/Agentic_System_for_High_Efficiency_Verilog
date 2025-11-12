`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: MAX, SLT, DIV, SNE, XOR, SLL, ADD, PASSB, SRA, ROL, MUL, SUB
// Flags: carry

module ALU_1139W16_b4d9f650(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam MAX = 4'd0;
    localparam SLT = 4'd1;
    localparam DIV = 4'd2;
    localparam SNE = 4'd3;
    localparam XOR = 4'd4;
    localparam SLL = 4'd5;
    localparam ADD = 4'd6;
    localparam PASSB = 4'd7;
    localparam SRA = 4'd8;
    localparam ROL = 4'd9;
    localparam MUL = 4'd10;
    localparam SUB = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SLT: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SNE: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            PASSB: begin
                result = input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            MUL: begin
                result = input1 * input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            default: result = 16'b0;
        endcase
    end

endmodule