`timescale 1ns / 1ps

// Generated ALU Module
// Style: STANDARD
// Bit width: 16
// Operations: ADD, SUB, AND, OR, XNOR, SEQ, SRA, NOR, MAX, NAND, SLL
// Flags: carry, zero, overflow

module ALU_1185W16_ee7826b6(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [15:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire overFlowFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam OR = 4'd3;
    localparam XNOR = 4'd4;
    localparam SEQ = 4'd5;
    localparam SRA = 4'd6;
    localparam NOR = 4'd7;
    localparam MAX = 4'd8;
    localparam NAND = 4'd9;
    localparam SLL = 4'd10;

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
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SEQ: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
    end

endmodule