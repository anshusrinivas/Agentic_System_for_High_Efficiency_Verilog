`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: MAX, SUB, AND, XNOR, SRA, SRL, ADD, SNE, SLTU, SGE, NOR
// Flags: carry, zero, sign

module ALU_1481W16_efd99830(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam MAX = 4'd0;
    localparam SUB = 4'd1;
    localparam AND = 4'd2;
    localparam XNOR = 4'd3;
    localparam SRA = 4'd4;
    localparam SRL = 4'd5;
    localparam ADD = 4'd6;
    localparam SNE = 4'd7;
    localparam SLTU = 4'd8;
    localparam SGE = 4'd9;
    localparam NOR = 4'd10;

    // Combinational logic
    always @(*) begin
        case (opcode)
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            SUB: begin
                result = input1 - input2;
                
            end
            AND: begin
                result = input1 & input2;
            end
            XNOR: begin
                result = ~(input1 ^ input2);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SNE: begin
            end
            SLTU: begin
            end
            SGE: begin
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule