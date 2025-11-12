`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: NOR, MAX, SRA, XNOR, XOR, SNE, SLL, OR, SGE
// Flags: carry, zero, overflow, sign

module ALU_0665W32_f3f5c888(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam NOR = 4'd0;
    localparam MAX = 4'd1;
    localparam SRA = 4'd2;
    localparam XNOR = 4'd3;
    localparam XOR = 4'd4;
    localparam SNE = 4'd5;
    localparam SLL = 4'd6;
    localparam OR = 4'd7;
    localparam SGE = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SNE: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            SGE: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule