`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SGE, PASSB, MUL, SGT, XNOR, SLL, SLTU, OR
// Flags: carry, zero, overflow, sign

module ALU_1700W16_bcb1da53(
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
    localparam SGE = 4'd0;
    localparam PASSB = 4'd1;
    localparam MUL = 4'd2;
    localparam SGT = 4'd3;
    localparam XNOR = 4'd4;
    localparam SLL = 4'd5;
    localparam SLTU = 4'd6;
    localparam OR = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGE: begin
            end
            PASSB: begin
                result = input2;
            end
            MUL: begin
                result = input1 * input2;
            end
            SGT: begin
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SLTU: begin
            end
            OR: begin
                result = input1 | input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule