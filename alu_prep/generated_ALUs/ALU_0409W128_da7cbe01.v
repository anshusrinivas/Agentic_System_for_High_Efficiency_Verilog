`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SNE, DIV, XOR, SLT, ROR, SEQ, MAX, SGT, ADD
// Flags: carry, zero, overflow

module ALU_0409W128_da7cbe01(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SNE = 4'd0;
    localparam DIV = 4'd1;
    localparam XOR = 4'd2;
    localparam SLT = 4'd3;
    localparam ROR = 4'd4;
    localparam SEQ = 4'd5;
    localparam MAX = 4'd6;
    localparam SGT = 4'd7;
    localparam ADD = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SNE: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SLT: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SEQ: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SGT: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule