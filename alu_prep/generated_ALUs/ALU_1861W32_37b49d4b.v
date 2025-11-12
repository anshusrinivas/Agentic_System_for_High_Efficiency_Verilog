`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SGT, SLL, XNOR, SGE, MUL, SRA, MIN, DIV, SEQ, ADD
// Flags: carry, zero, sign

module ALU_1861W32_37b49d4b(
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
    localparam SGT = 4'd0;
    localparam SLL = 4'd1;
    localparam XNOR = 4'd2;
    localparam SGE = 4'd3;
    localparam MUL = 4'd4;
    localparam SRA = 4'd5;
    localparam MIN = 4'd6;
    localparam DIV = 4'd7;
    localparam SEQ = 4'd8;
    localparam ADD = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SGE: begin
            end
            MUL: begin
                result = input1 * input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            SEQ: begin
            end
            ADD: begin
                result = input1 + input2;
                
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule