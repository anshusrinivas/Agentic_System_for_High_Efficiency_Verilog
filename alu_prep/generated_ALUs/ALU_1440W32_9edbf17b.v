`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: XNOR, SRL, SLT, MUL, MIN, OR, ADD, PASSB, SEQ, XOR
// Flags: carry, zero, sign

module ALU_1440W32_9edbf17b(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam XNOR = 4'd0;
    localparam SRL = 4'd1;
    localparam SLT = 4'd2;
    localparam MUL = 4'd3;
    localparam MIN = 4'd4;
    localparam OR = 4'd5;
    localparam ADD = 4'd6;
    localparam PASSB = 4'd7;
    localparam SEQ = 4'd8;
    localparam XOR = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SLT: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            OR: begin
                result = input1 | input2;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            PASSB: begin
                result = input2;
            end
            SEQ: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule