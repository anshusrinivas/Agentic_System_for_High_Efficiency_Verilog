`timescale 1ns / 1ps

// Generated ALU Module
// Style: OPTIMIZED
// Bit width: 32
// Operations: ADD, SUB, AND, OR, SLL, MIN, SRA, SEQ, MAX, NAND
// Flags: carry

module ALU_0425W32_40868b4e(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam OR = 4'd3;
    localparam SLL = 4'd4;
    localparam MIN = 4'd5;
    localparam SRA = 4'd6;
    localparam SEQ = 4'd7;
    localparam MAX = 4'd8;
    localparam NAND = 4'd9;

    // Internal signals
    wire [32:0] sum = (opcode == SUB) ? 
                             {1'b0, input1} - {1'b0, input2} : 
                             {1'b0, input1} + {1'b0, input2};

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                
            end
            SUB: begin
                result = input1 - input2;
                
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
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SEQ: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            default: result = 32'b0;
        endcase
    end

endmodule