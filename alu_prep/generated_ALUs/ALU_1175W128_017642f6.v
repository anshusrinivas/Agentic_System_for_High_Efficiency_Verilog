`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 128
// Operations: SGT, SUB, NOR, PASSB, AND, SLT, ROR, SRL, SEQ, SGE
// Flags: carry

module ALU_1175W128_017642f6(
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SGT = 4'd0;
    localparam SUB = 4'd1;
    localparam NOR = 4'd2;
    localparam PASSB = 4'd3;
    localparam AND = 4'd4;
    localparam SLT = 4'd5;
    localparam ROR = 4'd6;
    localparam SRL = 4'd7;
    localparam SEQ = 4'd8;
    localparam SGE = 4'd9;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGT: begin
            end
            SUB: begin
                result = input1 - input2;
                
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            PASSB: begin
                result = input2;
            end
            AND: begin
                result = input1 & input2;
            end
            SLT: begin
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SEQ: begin
            end
            SGE: begin
            end
            default: result = 128'b0;
        endcase
    end

endmodule