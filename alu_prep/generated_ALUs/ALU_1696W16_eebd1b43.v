`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SUB, MAX, XNOR, PASSB, XOR, SGE, ADD
// Flags: carry, zero, overflow, sign

module ALU_1696W16_eebd1b43(
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
    localparam SUB = 4'd0;
    localparam MAX = 4'd1;
    localparam XNOR = 4'd2;
    localparam PASSB = 4'd3;
    localparam XOR = 4'd4;
    localparam SGE = 4'd5;
    localparam ADD = 4'd6;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SUB: begin
                result = input1 - input2;
                overflow = (input1[15] != input2[15]) && (result[15] != input1[15]);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            PASSB: begin
                result = input2;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SGE: begin
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[15] == input2[15]) && (result[15] != input1[15]);
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule