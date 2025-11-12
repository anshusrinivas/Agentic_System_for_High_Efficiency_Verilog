`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: XNOR, NOR, SLTU, MUL, XOR, AND, ADD, OR, SEQ, PASSB
// Flags: carry, zero, overflow

module ALU_0288W32_e3690c71(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam XNOR = 4'd0;
    localparam NOR = 4'd1;
    localparam SLTU = 4'd2;
    localparam MUL = 4'd3;
    localparam XOR = 4'd4;
    localparam AND = 4'd5;
    localparam ADD = 4'd6;
    localparam OR = 4'd7;
    localparam SEQ = 4'd8;
    localparam PASSB = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLTU: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            AND: begin
                result = input1 & input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            OR: begin
                result = input1 | input2;
            end
            SEQ: begin
            end
            PASSB: begin
                result = input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule