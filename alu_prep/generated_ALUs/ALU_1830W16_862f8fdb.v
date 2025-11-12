`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLTU, SRA, ROR, MUL, ADD, AND, ROL, SLT, MAX
// Flags: carry

module ALU_1830W16_862f8fdb(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SLTU = 4'd0;
    localparam SRA = 4'd1;
    localparam ROR = 4'd2;
    localparam MUL = 4'd3;
    localparam ADD = 4'd4;
    localparam AND = 4'd5;
    localparam ROL = 4'd6;
    localparam SLT = 4'd7;
    localparam MAX = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLTU: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            AND: begin
                result = input1 & input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            default: result = 16'b0;
        endcase
    end

endmodule