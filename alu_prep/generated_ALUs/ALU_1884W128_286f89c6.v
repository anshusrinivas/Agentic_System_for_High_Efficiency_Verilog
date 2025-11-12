`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: MIN, SGT, SLTU, MUL, ADD, XNOR, SRL, MAX, SGE, SRA
// Flags: carry, zero, overflow, sign

module ALU_1884W128_286f89c6(
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
    localparam MIN = 4'd0;
    localparam SGT = 4'd1;
    localparam SLTU = 4'd2;
    localparam MUL = 4'd3;
    localparam ADD = 4'd4;
    localparam XNOR = 4'd5;
    localparam SRL = 4'd6;
    localparam MAX = 4'd7;
    localparam SGE = 4'd8;
    localparam SRA = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SGT: begin
            end
            SLTU: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[127] == input2[127]) && (result[127] != input1[127]);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SGE: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule