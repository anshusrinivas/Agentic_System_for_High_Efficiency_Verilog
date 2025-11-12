`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SLTU, MAX, DIV, SGE, SRA, AND
// Flags: carry, zero, sign

module ALU_1391W32_67c70c81(
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
    localparam SLTU = 4'd0;
    localparam MAX = 4'd1;
    localparam DIV = 4'd2;
    localparam SGE = 4'd3;
    localparam SRA = 4'd4;
    localparam AND = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLTU: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            SGE: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            AND: begin
                result = input1 & input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule