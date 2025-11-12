`timescale 1ns / 1ps

// Generated ALU Module
// Style: STANDARD
// Bit width: 16
// Operations: ADD, SUB, AND, OR, SLL, MUL, XOR, MAX
// Flags: carry

module ALU_1340W16_e04338cd(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [15:0] result
    ,output wire carryFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam OR = 4'd3;
    localparam SLL = 4'd4;
    localparam MUL = 4'd5;
    localparam XOR = 4'd6;
    localparam MAX = 4'd7;

    // Internal signals
    wire [16:0] sum = (opcode == SUB) ? 
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
            MUL: begin
                result = input1 * input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            default: result = 16'b0;
        endcase
    end

endmodule