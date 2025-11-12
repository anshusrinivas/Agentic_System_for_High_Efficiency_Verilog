`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: MAX, MIN, SLT, ROL, OR, SUB
// Flags: carry

module ALU_1316W128_d8765d7f(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam MAX = 4'd0;
    localparam MIN = 4'd1;
    localparam SLT = 4'd2;
    localparam ROL = 4'd3;
    localparam OR = 4'd4;
    localparam SUB = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLT: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            OR: begin
                result = input1 | input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            default: result = 128'b0;
        endcase
    end

endmodule