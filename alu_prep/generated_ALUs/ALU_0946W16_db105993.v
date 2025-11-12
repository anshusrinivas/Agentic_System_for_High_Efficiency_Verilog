`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: XNOR, NAND, OR, SEQ, SGT, ADD, SLL, SLTU
// Flags: carry

module ALU_0946W16_db105993(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam XNOR = 4'd0;
    localparam NAND = 4'd1;
    localparam OR = 4'd2;
    localparam SEQ = 4'd3;
    localparam SGT = 4'd4;
    localparam ADD = 4'd5;
    localparam SLL = 4'd6;
    localparam SLTU = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            NAND: begin
                result = ~(input1 & input2);
            end
            OR: begin
                result = input1 | input2;
            end
            SEQ: begin
            end
            SGT: begin
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            SLTU: begin
            end
            default: result = 16'b0;
        endcase
    end

endmodule