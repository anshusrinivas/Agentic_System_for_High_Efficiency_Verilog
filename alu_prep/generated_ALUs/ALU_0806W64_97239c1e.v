`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 64
// Operations: SGT, SLT, SLTU, SUB, DIV, AND, SGE, XOR, SRL, PASSB
// Flags: carry

module ALU_0806W64_97239c1e(
    input  wire [3:0]  opcode,
    input  wire [63:0] input1,
    input  wire [63:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [63:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SGT = 4'd0;
    localparam SLT = 4'd1;
    localparam SLTU = 4'd2;
    localparam SUB = 4'd3;
    localparam DIV = 4'd4;
    localparam AND = 4'd5;
    localparam SGE = 4'd6;
    localparam XOR = 4'd7;
    localparam SRL = 4'd8;
    localparam PASSB = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            SLT: begin
            end
            SLTU: begin
            end
            SUB: begin
                result = input1 - input2;
                
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 64'b0;
            end
            AND: begin
                result = input1 & input2;
            end
            SGE: begin
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            default: result = 64'b0;
        endcase
    end

endmodule