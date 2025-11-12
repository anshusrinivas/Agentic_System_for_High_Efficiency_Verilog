`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: MIN, AND, SLT, SUB, ROR, XNOR, XOR, SGE, PASSB, SGT, SRL, SLTU, SNE, MAX
// Flags: carry, zero, sign

module ALU_0993W64_1ff04e89(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam MIN = 4'd0;
    localparam AND = 4'd1;
    localparam SLT = 4'd2;
    localparam SUB = 4'd3;
    localparam ROR = 4'd4;
    localparam XNOR = 4'd5;
    localparam XOR = 4'd6;
    localparam SGE = 4'd7;
    localparam PASSB = 4'd8;
    localparam SGT = 4'd9;
    localparam SRL = 4'd10;
    localparam SLTU = 4'd11;
    localparam SNE = 4'd12;
    localparam MAX = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SLT: begin
            end
            SUB: begin
                result = input1 - input2;
                
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SGE: begin
            end
            PASSB: begin
                result = input2;
            end
            SGT: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SLTU: begin
            end
            SNE: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            default: result = 64'b0;
        endcase
        zeroFlag = (result == 64'b0);
        signFlag = result[63];
    end

endmodule