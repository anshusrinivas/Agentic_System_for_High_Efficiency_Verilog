`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 8
// Operations: SRA, XOR, ROL, MIN, SGT, SEQ, ADD, SRL, SUB, NOR
// Flags: carry

module ALU_1464W8_213e6691(
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SRA = 4'd0;
    localparam XOR = 4'd1;
    localparam ROL = 4'd2;
    localparam MIN = 4'd3;
    localparam SGT = 4'd4;
    localparam SEQ = 4'd5;
    localparam ADD = 4'd6;
    localparam SRL = 4'd7;
    localparam SUB = 4'd8;
    localparam NOR = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            XOR: begin
                result = input1 ^ input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SGT: begin
            end
            SEQ: begin
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            default: result = 8'b0;
        endcase
    end

endmodule