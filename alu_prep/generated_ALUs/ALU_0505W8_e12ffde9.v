`timescale 1ns / 1ps

// Generated ALU Module
// Style: STANDARD
// Bit width: 8
// Operations: ADD, SUB, AND, OR, SRL, XOR, MAX
// Flags: carry, zero, overflow

module ALU_0505W8_e12ffde9(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output wire [7:0] result
    ,output wire carryFlag
    ,output wire zeroFlag
    ,output wire overFlowFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam OR = 4'd3;
    localparam SRL = 4'd4;
    localparam XOR = 4'd5;
    localparam MAX = 4'd6;

    // Internal signals
    wire [8:0] sum = (opcode == SUB) ? 
                             {1'b0, input1} - {1'b0, input2} : 
                             {1'b0, input1} + {1'b0, input2};

    // Combinational logic
    always @(*) begin
        case (opcode)
            ADD: begin
                result = input1 + input2;
                overflow = (input1[7] == input2[7]) && (result[7] != input1[7]);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[7] != input2[7]) && (result[7] != input1[7]);
            end
            AND: begin
                result = input1 & input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            default: result = 8'b0;
        endcase
        zeroFlag = (result == 8'b0);
    end

endmodule