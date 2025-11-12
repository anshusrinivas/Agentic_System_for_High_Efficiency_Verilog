`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 32
// Operations: ADD, SUB, MUL, NAND, SEQ, PASSB, ROR, ROL, SRL, SRA
// Flags: carry, zero, sign

module ALU_0483W32_953825ce(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [31:0] input1,
    input  wire [31:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [31:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam NAND = 4'd3;
    localparam SEQ = 4'd4;
    localparam PASSB = 4'd5;
    localparam ROR = 4'd6;
    localparam ROL = 4'd7;
    localparam SRL = 4'd8;
    localparam SRA = 4'd9;

    // Pipeline registers
    reg [31:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 32'b0;
            input2_r <= 32'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 32'b0;
            carryFlag <= 1'b0;
            zeroFlag <= 1'b0;
            signFlag <= 1'b0;
        end else begin
            input1_r <= input1;
            input2_r <= input2;
            opcode_r <= opcode;
            shiftValue_r <= shiftValue;

            case (opcode_r)
                ADD: begin
                    {carryFlag, result} <= {1'b0, input1_r} + {1'b0, input2_r};
                    
                end
                SUB: begin
                    {carryFlag, result} <= {1'b0, input1_r} - {1'b0, input2_r};
                    
                end
                MUL: begin
                    result <= input1_r * input2_r;
                end
                NAND: begin
                    result <= ~(input1_r & input2_r);
                end
                SEQ: begin
                end
                PASSB: begin
                    result <= input2_r;
                end
                ROR: begin
                    result <= ror(input1_r, shiftValue_r);
                end
                ROL: begin
                    result <= rol(input1_r, shiftValue_r);
                end
                SRL: begin
                    result <= input1_r >> shiftValue_r;
                end
                SRA: begin
                    result <= $signed(input1_r) >>> shiftValue_r;
                end
            default: result <= 32'b0;
        endcase
    end

endmodule