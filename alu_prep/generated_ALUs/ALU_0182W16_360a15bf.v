`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: PASSB, ROR, XNOR, SLTU, SRL, NOR, SLT, DIV, SRA, SGE
// Flags: carry, zero, overflow, sign

module ALU_0182W16_360a15bf(
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
    localparam PASSB = 4'd0;
    localparam ROR = 4'd1;
    localparam XNOR = 4'd2;
    localparam SLTU = 4'd3;
    localparam SRL = 4'd4;
    localparam NOR = 4'd5;
    localparam SLT = 4'd6;
    localparam DIV = 4'd7;
    localparam SRA = 4'd8;
    localparam SGE = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            PASSB: begin
                result = input2;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SLTU: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SLT: begin
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 16'b0;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGE: begin
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule