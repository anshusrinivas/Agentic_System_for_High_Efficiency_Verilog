`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRL, SRA, SLT, SLTU, ADD, SGT
// Flags: carry

module ALU_1746W16_4bfbf788(
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
);

    // Operation codes
    localparam SRL = 4'd0;
    localparam SRA = 4'd1;
    localparam SLT = 4'd2;
    localparam SLTU = 4'd3;
    localparam ADD = 4'd4;
    localparam SGT = 4'd5;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRL: begin
                result = input1 >> shiftValue;
            end
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            SLT: begin
            end
            SLTU: begin
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SGT: begin
            end
            default: result = 16'b0;
        endcase
    end

endmodule