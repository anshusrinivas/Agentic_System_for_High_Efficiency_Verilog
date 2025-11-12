`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: NOR, DIV, SUB, XOR, MIN, MUL
// Flags: carry

module ALU_1702W8_ab291e37(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam NOR = 4'd0;
    localparam DIV = 4'd1;
    localparam SUB = 4'd2;
    localparam XOR = 4'd3;
    localparam MIN = 4'd4;
    localparam MUL = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            NOR: begin
                result = ~(input1 | input2);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 8'b0;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 8'b0;
        endcase
    end

endmodule