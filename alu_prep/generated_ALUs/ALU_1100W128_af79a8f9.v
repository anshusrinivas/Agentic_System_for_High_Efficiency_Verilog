`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SEQ, SGT, NOR, ADD, PASSB, AND, SGE, SLL, SRA, MUL
// Flags: carry, zero, sign

module ALU_1100W128_af79a8f9(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SEQ = 4'd0;
    localparam SGT = 4'd1;
    localparam NOR = 4'd2;
    localparam ADD = 4'd3;
    localparam PASSB = 4'd4;
    localparam AND = 4'd5;
    localparam SGE = 4'd6;
    localparam SLL = 4'd7;
    localparam SRA = 4'd8;
    localparam MUL = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SEQ: begin
            end
            SGT: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            PASSB: begin
                result = input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SGE: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule