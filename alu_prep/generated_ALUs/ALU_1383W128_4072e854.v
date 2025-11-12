`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SRA, AND, SGE, PASSB, XNOR, SUB, DIV, SRL
// Flags: carry, zero, overflow

module ALU_1383W128_4072e854(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SRA = 4'd0;
    localparam AND = 4'd1;
    localparam SGE = 4'd2;
    localparam PASSB = 4'd3;
    localparam XNOR = 4'd4;
    localparam SUB = 4'd5;
    localparam DIV = 4'd6;
    localparam SRL = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            AND: begin
                result = input1 & input2;
            end
            SGE: begin
            end
            PASSB: begin
                result = input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SUB: begin
                result = input1 - input2;
                overflow = (input1[127] != input2[127]) && (result[127] != input1[127]);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
    end

endmodule