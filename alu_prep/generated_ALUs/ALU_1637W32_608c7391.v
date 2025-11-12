`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 32
// Operations: ROL, SRA, OR, SGE, PASSB, ADD, NOR, MAX
// Flags: carry

module ALU_1637W32_608c7391(
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam ROL = 4'd0;
    localparam SRA = 4'd1;
    localparam OR = 4'd2;
    localparam SGE = 4'd3;
    localparam PASSB = 4'd4;
    localparam ADD = 4'd5;
    localparam NOR = 4'd6;
    localparam MAX = 4'd7;

    // Combinational logic
    always @(*) begin
        case (opcode)
            ROL: begin
                result = rol(input1, shiftValue);
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            OR: begin
                result = input1 | input2;
            end
            SGE: begin
            end
            PASSB: begin
                result = input2;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            NOR: begin
                result = ~(input1 | input2);
            end
            MAX: begin
                result = (input1 > input2) ? input1 : input2;
            end
            default: result = 32'b0;
        endcase
    end

endmodule