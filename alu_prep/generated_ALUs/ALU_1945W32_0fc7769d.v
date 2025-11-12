`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: MIN, PASSB, OR, SUB, DIV, SLTU, SRA, SGT, SEQ, SLL, XNOR, SLT, ROL, ROR
// Flags: carry, zero, sign

module ALU_1945W32_0fc7769d(
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
    localparam MIN = 4'd0;
    localparam PASSB = 4'd1;
    localparam OR = 4'd2;
    localparam SUB = 4'd3;
    localparam DIV = 4'd4;
    localparam SLTU = 4'd5;
    localparam SRA = 4'd6;
    localparam SGT = 4'd7;
    localparam SEQ = 4'd8;
    localparam SLL = 4'd9;
    localparam XNOR = 4'd10;
    localparam SLT = 4'd11;
    localparam ROL = 4'd12;
    localparam ROR = 4'd13;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            PASSB: begin
                result = input2;
            end
            OR: begin
                result = input1 | input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            SLTU: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGT: begin
            end
            SEQ: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SLT: begin
            end
            ROL: begin
                result = rol(input1, shiftValue);
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