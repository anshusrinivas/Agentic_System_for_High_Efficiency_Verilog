`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SEQ, MIN, SLT, MUL, ADD, SRA, SGE
// Flags: carry, zero, overflow

module ALU_0939W64_24dfd184(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SEQ = 4'd0;
    localparam MIN = 4'd1;
    localparam SLT = 4'd2;
    localparam MUL = 4'd3;
    localparam ADD = 4'd4;
    localparam SRA = 4'd5;
    localparam SGE = 4'd6;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SEQ: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLT: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[63] == input2[63]) && (result[63] != input1[63]);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGE: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
    end

endmodule