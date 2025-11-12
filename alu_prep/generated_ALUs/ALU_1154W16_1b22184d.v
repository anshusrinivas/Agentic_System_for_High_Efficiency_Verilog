`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: ROL, SGT, SNE, SGE, SEQ, XNOR, NOR, MUL, SUB
// Flags: carry

module ALU_1154W16_1b22184d(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam ROL = 4'd0;
    localparam SGT = 4'd1;
    localparam SNE = 4'd2;
    localparam SGE = 4'd3;
    localparam SEQ = 4'd4;
    localparam XNOR = 4'd5;
    localparam NOR = 4'd6;
    localparam MUL = 4'd7;
    localparam SUB = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SGT: begin
            end
            SNE: begin
            end
            SGE: begin
            end
            SEQ: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            default: result = 16'b0;
        endcase
    end

endmodule