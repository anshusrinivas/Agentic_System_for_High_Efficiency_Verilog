`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: MIN, SLL, SEQ, SGE, NOR, SRA, ROL, SUB
// Flags: carry, zero, sign

module ALU_0689W128_073cc630(
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
    localparam MIN = 4'd0;
    localparam SLL = 4'd1;
    localparam SEQ = 4'd2;
    localparam SGE = 4'd3;
    localparam NOR = 4'd4;
    localparam SRA = 4'd5;
    localparam ROL = 4'd6;
    localparam SUB = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SEQ: begin
            end
            SGE: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SUB: begin
                result = input1 - input2;
                
            end
            default: result = 128'b0;
        endcase
        zeroFlag = (result == 128'b0);
        signFlag = result[127];
    end

endmodule