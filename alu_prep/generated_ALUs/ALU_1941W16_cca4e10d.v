`timescale 1ns / 1ps

// Generated ALU Module
// Style: OPTIMIZED
// Bit width: 16
// Operations: ADD, SUB, AND, OR, SLL, SLT, SGT, SNE, MAX, MUL
// Flags: carry, zero, overflow, sign

module ALU_1941W16_cca4e10d(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam OR = 4'd3;
    localparam SLL = 4'd4;
    localparam SLT = 4'd5;
    localparam SGT = 4'd6;
    localparam SNE = 4'd7;
    localparam MAX = 4'd8;
    localparam MUL = 4'd9;

    // Internal signals
    wire [16:0] sum = (opcode == SUB) ? 
                             {1'b0, input1} - {1'b0, input2} : 
                             {1'b0, input1} + {1'b0, input2};

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            AND: begin
                result = input1 & input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SLT: begin
            end
            SGT: begin
            end
            SNE: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule