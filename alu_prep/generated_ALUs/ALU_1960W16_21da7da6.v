`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SLT, MIN, PASSB, NAND, SLTU, SLL, ADD
// Flags: carry

module ALU_1960W16_21da7da6(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SLT = 4'd0;
    localparam MIN = 4'd1;
    localparam PASSB = 4'd2;
    localparam NAND = 4'd3;
    localparam SLTU = 4'd4;
    localparam SLL = 4'd5;
    localparam ADD = 4'd6;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SLT: begin
            end
            MIN: begin
                result = (input1 < input2) ? input1 : input2;
            end
            PASSB: begin
                result = input2;
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            SLTU: begin
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            default: result = 16'b0;
        endcase
    end

endmodule