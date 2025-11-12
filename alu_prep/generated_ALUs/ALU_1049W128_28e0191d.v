`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: XOR, SLL, SUB, SRA, DIV, MUL, XNOR, SGE, ADD, ROL, SNE, ROR
// Flags: carry, zero, overflow, sign

module ALU_1049W128_28e0191d(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam XOR = 4'd0;
    localparam SLL = 4'd1;
    localparam SUB = 4'd2;
    localparam SRA = 4'd3;
    localparam DIV = 4'd4;
    localparam MUL = 4'd5;
    localparam XNOR = 4'd6;
    localparam SGE = 4'd7;
    localparam ADD = 4'd8;
    localparam ROL = 4'd9;
    localparam SNE = 4'd10;
    localparam ROR = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            MUL: begin
                result = input1 * input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SGE: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SNE: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule