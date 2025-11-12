`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLL, NAND, XNOR, AND, SGE, SLTU, SGT, PASSB, SRA, XOR
// Flags: carry, zero, overflow, sign

module ALU_0151W16_fcd679db(
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
    localparam SLL = 4'd0;
    localparam NAND = 4'd1;
    localparam XNOR = 4'd2;
    localparam AND = 4'd3;
    localparam SGE = 4'd4;
    localparam SLTU = 4'd5;
    localparam SGT = 4'd6;
    localparam PASSB = 4'd7;
    localparam SRA = 4'd8;
    localparam XOR = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLL: begin
                result = input1 << shiftValue;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            AND: begin
                result = input1 & input2;
            end
            SGE: begin
            end
            SLTU: begin
            end
            SGT: begin
            end
            PASSB: begin
                result = input2;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule