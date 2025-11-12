`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: SGE, SRL, MAX, DIV, OR, SGT, MIN, SUB, SEQ
// Flags: carry

module ALU_0926W32_e1319aad(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SGE = 4'd0;
    localparam SRL = 4'd1;
    localparam MAX = 4'd2;
    localparam DIV = 4'd3;
    localparam OR = 4'd4;
    localparam SGT = 4'd5;
    localparam MIN = 4'd6;
    localparam SUB = 4'd7;
    localparam SEQ = 4'd8;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SGE: begin
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            DIV: begin
                result = (input2 != 0) ? input1 / input2 : 32'b0;
            end
            OR: begin
                result = input1 | input2;
            end
            SGT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SEQ: begin
            end
            default: result = 32'b0;
        endcase
    end

endmodule