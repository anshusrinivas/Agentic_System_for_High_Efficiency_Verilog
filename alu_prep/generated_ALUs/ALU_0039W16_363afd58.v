`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SGE, OR, SLL, SUB, MIN, SEQ, XOR, XNOR, SGT
// Flags: carry, zero, sign

module ALU_0039W16_363afd58(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam SGE = 4'd0;
    localparam OR = 4'd1;
    localparam SLL = 4'd2;
    localparam SUB = 4'd3;
    localparam MIN = 4'd4;
    localparam SEQ = 4'd5;
    localparam XOR = 4'd6;
    localparam XNOR = 4'd7;
    localparam SGT = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGE: begin
            end
            OR: begin
                result = input1 | input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SEQ: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SGT: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule