`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: ADD, SUB, DIV, SLL, SLT, NAND, NOR, SLTU, SEQ, MAX
// Flags: carry, zero, sign

module ALU_1934W32_ac707921(
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
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam DIV = 4'd2;
    localparam SLL = 4'd3;
    localparam SLT = 4'd4;
    localparam NAND = 4'd5;
    localparam NOR = 4'd6;
    localparam SLTU = 4'd7;
    localparam SEQ = 4'd8;
    localparam MAX = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                
            end
            SUB: begin
                result = input1 - input2;
                
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SLT: begin
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLTU: begin
            end
            SEQ: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule