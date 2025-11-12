`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SRL, PASSB, SLTU, SGT, MIN, AND, ROL, NAND, SUB
// Flags: carry, zero, sign

module ALU_0448W32_8f2bb26b(
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
    localparam SRL = 4'd0;
    localparam PASSB = 4'd1;
    localparam SLTU = 4'd2;
    localparam SGT = 4'd3;
    localparam MIN = 4'd4;
    localparam AND = 4'd5;
    localparam ROL = 4'd6;
    localparam NAND = 4'd7;
    localparam SUB = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            SLTU: begin
            end
            SGT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            AND: begin
                result = input1 & input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SUB: begin
                result = input1 - input2;
                
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
        signFlag = result[31];
    end

endmodule