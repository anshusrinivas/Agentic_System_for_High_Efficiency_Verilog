`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SRA, ROL, DIV, PASSB, SNE, SRL, OR, NOR, ROR, ADD, XNOR, MIN, AND
// Flags: carry, zero, overflow

module ALU_1684W32_920680b4(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam SRA = 4'd0;
    localparam ROL = 4'd1;
    localparam DIV = 4'd2;
    localparam PASSB = 4'd3;
    localparam SNE = 4'd4;
    localparam SRL = 4'd5;
    localparam OR = 4'd6;
    localparam NOR = 4'd7;
    localparam ROR = 4'd8;
    localparam ADD = 4'd9;
    localparam XNOR = 4'd10;
    localparam MIN = 4'd11;
    localparam AND = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            PASSB: begin
                result = input2;
            end
            SNE: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            ADD: begin
                result = input1 + input2;
                overflow = (input1[31] == input2[31]) && (result[31] != input1[31]);
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            AND: begin
                result = input1 & input2;
            end
            default: result = 32'b0;
        endcase
        zeroFlag = (result == 32'b0);
    end

endmodule