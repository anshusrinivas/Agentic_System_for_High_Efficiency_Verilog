`timescale 1ns / 1ps

// Generated ALU Module
// Style: STANDARD
// Bit width: 32
// Operations: ADD, SUB, AND, OR, SGT, SRA, MUL, SLT
// Flags: carry, zero, sign

module ALU_0154W32_ab48f4b7(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [31:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam OR = 4'd3;
    localparam SGT = 4'd4;
    localparam SRA = 4'd5;
    localparam MUL = 4'd6;
    localparam SLT = 4'd7;

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
            SGT: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            MUL: begin
                result = input1 * input2;
            end
            SLT: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule