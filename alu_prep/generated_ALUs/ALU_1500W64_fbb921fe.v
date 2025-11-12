`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SEQ, MUL, SRA, XOR, SGE, ADD, MAX, SLT
// Flags: carry, zero, sign

module ALU_1500W64_fbb921fe(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SEQ = 4'd0;
    localparam MUL = 4'd1;
    localparam SRA = 4'd2;
    localparam XOR = 4'd3;
    localparam SGE = 4'd4;
    localparam ADD = 4'd5;
    localparam MAX = 4'd6;
    localparam SLT = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SEQ: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SGE: begin
            end
            ADD: begin
                result = input1 + input2;
                
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SLT: begin
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule