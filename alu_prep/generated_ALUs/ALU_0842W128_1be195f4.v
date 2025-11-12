`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: ROL, ADD, DIV, SGT, SRA, OR, PASSB, SLTU, MIN, NOR, MUL
// Flags: carry, zero, sign

module ALU_0842W128_1be195f4(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ROL = 4'd0;
    localparam ADD = 4'd1;
    localparam DIV = 4'd2;
    localparam SGT = 4'd3;
    localparam SRA = 4'd4;
    localparam OR = 4'd5;
    localparam PASSB = 4'd6;
    localparam SLTU = 4'd7;
    localparam MIN = 4'd8;
    localparam NOR = 4'd9;
    localparam MUL = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROL: begin
                result = rol(input1, shiftValue);
            end
            ADD: begin
                result = input1 + input2;
                
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 128'b0;
            end
            SGT: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            PASSB: begin
                result = input2;
            end
            SLTU: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule