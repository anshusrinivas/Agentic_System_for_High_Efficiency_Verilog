`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLT, SLTU, MAX, SGE, SUB, SLL, MIN, ROL
// Flags: carry

module ALU_1804W16_33f4e440(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SLT = 4'd0;
    localparam SLTU = 4'd1;
    localparam MAX = 4'd2;
    localparam SGE = 4'd3;
    localparam SUB = 4'd4;
    localparam SLL = 4'd5;
    localparam MIN = 4'd6;
    localparam ROL = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            SLTU: begin
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SGE: begin
            end
            SUB: begin
                result = input1 - input2;
                
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            ROL: begin
                result = rol(input1, shiftValue);
            end
            default: result = 16'b0;
        endcase
    end

endmodule