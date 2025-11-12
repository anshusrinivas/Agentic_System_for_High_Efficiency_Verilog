`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLTU, SLT, MAX, SNE, SUB, ROR, ROL, OR
// Flags: carry

module ALU_1848W16_d2232282(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SLTU = 4'd0;
    localparam SLT = 4'd1;
    localparam MAX = 4'd2;
    localparam SNE = 4'd3;
    localparam SUB = 4'd4;
    localparam ROR = 4'd5;
    localparam ROL = 4'd6;
    localparam OR = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLTU: begin
            end
            SLT: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SNE: begin
            end
            SUB: begin
                result = input1 - input2;
                
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            OR: begin
                result = input1 | input2;
            end
            default: result = 16'b0;
        endcase
    end

endmodule