`timescale 1ns / 1ps

// Generated ALU Module
// Style: MODULAR
// Bit width: 16
// Operations: SRA, ADD, SRL, SLTU, SNE, PASSB, SLL
// Flags: carry, zero, sign

module ALU_0088W16_c62a7d28(
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
    localparam SRA = 4'd0;
    localparam ADD = 4'd1;
    localparam SRL = 4'd2;
    localparam SLTU = 4'd3;
    localparam SNE = 4'd4;
    localparam PASSB = 4'd5;
    localparam SLL = 4'd6;

    // Combinational logic
    always @(*) begin
        case (opcode)
            SRA: begin
                result = $signed(input1) >>> shiftValue;
            end
            ADD: begin
                result = input1 + input2;
                
            end
            SRL: begin
                result = input1 >> shiftValue;
            end
            SLTU: begin
            end
            SNE: begin
            end
            PASSB: begin
                result = input2;
            end
            SLL: begin
                result = input1 << shiftValue;
            end
            default: result = 16'b0;
        endcase
        zeroFlag = (result == 16'b0);
        signFlag = result[15];
    end

endmodule