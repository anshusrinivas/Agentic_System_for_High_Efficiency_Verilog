`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: XNOR, XOR, SUB, SLT, MUL, ROL
// Flags: carry

module ALU_1909W16_979b1ae2(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam XNOR = 4'd0;
    localparam XOR = 4'd1;
    localparam SUB = 4'd2;
    localparam SLT = 4'd3;
    localparam MUL = 4'd4;
    localparam ROL = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SLT: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            default: result = 16'b0;
        endcase
    end

endmodule