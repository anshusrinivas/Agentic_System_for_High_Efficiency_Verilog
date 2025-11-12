`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SEQ, SRA, ROR, XOR, SLL, PASSB, MAX, ROL, SLT, SGE, SUB, XNOR, MUL
// Flags: carry

module ALU_0788W16_b30d60e6(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SEQ = 4'd0;
    localparam SRA = 4'd1;
    localparam ROR = 4'd2;
    localparam XOR = 4'd3;
    localparam SLL = 4'd4;
    localparam PASSB = 4'd5;
    localparam MAX = 4'd6;
    localparam ROL = 4'd7;
    localparam SLT = 4'd8;
    localparam SGE = 4'd9;
    localparam SUB = 4'd10;
    localparam XNOR = 4'd11;
    localparam MUL = 4'd12;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SEQ: begin
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ROR: begin
                result = ror(input1, shiftValue);
            end
            XOR: begin
                result = input1 ^ input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            PASSB: begin
                result = input2;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SLT: begin
            end
            SGE: begin
            end
            SUB: begin
                result = input1 - input2;
                
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            MUL: begin
                result = input1 * input2;
            end
            default: result = 16'b0;
        endcase
    end

endmodule