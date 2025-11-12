`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: XOR, XNOR, ADD, SNE, OR, PASSB, SGT, MIN, ROR
// Flags: carry, zero, sign

module ALU_0426W32_c76eb78c(
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
    localparam XOR = 4'd0;
    localparam XNOR = 4'd1;
    localparam ADD = 4'd2;
    localparam SNE = 4'd3;
    localparam OR = 4'd4;
    localparam PASSB = 4'd5;
    localparam SGT = 4'd6;
    localparam MIN = 4'd7;
    localparam ROR = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SNE: begin
            end
            OR: begin
                result = input1 | input2;
            end
            PASSB: begin
                result = input2;
            end
            SGT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule