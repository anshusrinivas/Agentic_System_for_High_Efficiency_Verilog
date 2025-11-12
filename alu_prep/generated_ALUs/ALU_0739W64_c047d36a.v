`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: MUL, ADD, NOR, PASSB, SLTU, MAX, XNOR, MIN, SRL
// Flags: carry, zero, overflow

module ALU_0739W64_c047d36a(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam MUL = 4'd0;
    localparam ADD = 4'd1;
    localparam NOR = 4'd2;
    localparam PASSB = 4'd3;
    localparam SLTU = 4'd4;
    localparam MAX = 4'd5;
    localparam XNOR = 4'd6;
    localparam MIN = 4'd7;
    localparam SRL = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            PASSB: begin
                result = input2;
            end
            SLTU: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule