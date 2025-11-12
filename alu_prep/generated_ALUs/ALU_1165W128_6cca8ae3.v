`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: OR, SRA, XNOR, MUL, SLL, PASSB, SGT, SLTU, MIN
// Flags: carry, zero, overflow, sign

module ALU_1165W128_6cca8ae3(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam OR = 4'd0;
    localparam SRA = 4'd1;
    localparam XNOR = 4'd2;
    localparam MUL = 4'd3;
    localparam SLL = 4'd4;
    localparam PASSB = 4'd5;
    localparam SGT = 4'd6;
    localparam SLTU = 4'd7;
    localparam MIN = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            OR: begin
                result = input1 | input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            SGT: begin
            end
            SLTU: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule