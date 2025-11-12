`timescale 1ns / 1ps

// Generated ALU Module
// Style: OPTIMIZED
// Bit width: 32
// Operations: ADD, SUB, AND, OR, SLL, SLT, MAX, SLTU, ROL, XNOR, SGT
// Flags: carry, zero, sign

module ALU_1422W32_d2006214(
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
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam OR = 4'd3;
    localparam SLL = 4'd4;
    localparam SLT = 4'd5;
    localparam MAX = 4'd6;
    localparam SLTU = 4'd7;
    localparam ROL = 4'd8;
    localparam XNOR = 4'd9;
    localparam SGT = 4'd10;

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
            SLT: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SLTU: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SGT: begin
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule