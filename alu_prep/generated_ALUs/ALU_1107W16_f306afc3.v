`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: XOR, SUB, SRA, SGE, OR, SLTU, SLT
// Flags: carry

module ALU_1107W16_f306afc3(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam XOR = 4'd0;
    localparam SUB = 4'd1;
    localparam SRA = 4'd2;
    localparam SGE = 4'd3;
    localparam OR = 4'd4;
    localparam SLTU = 4'd5;
    localparam SLT = 4'd6;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XOR: begin
                result = input1 ^ input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SGE: begin
            end
            OR: begin
                result = input1 | input2;
            end
            SLTU: begin
            end
            SLT: begin
            end
            default: result = 16'b0;
        endcase
    end

endmodule