`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: NOR, SLL, MAX, XOR, SRA, ADD, OR, SLT, SRL, PASSB, DIV, NAND
// Flags: carry

module ALU_1605W16_48e7df85(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam NOR = 4'd0;
    localparam SLL = 4'd1;
    localparam MAX = 4'd2;
    localparam XOR = 4'd3;
    localparam SRA = 4'd4;
    localparam ADD = 4'd5;
    localparam OR = 4'd6;
    localparam SLT = 4'd7;
    localparam SRL = 4'd8;
    localparam PASSB = 4'd9;
    localparam DIV = 4'd10;
    localparam NAND = 4'd11;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            OR: begin
                result = input1 | input2;
            end
            SLT: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            default: result = 16'b0;
        endcase
    end

endmodule