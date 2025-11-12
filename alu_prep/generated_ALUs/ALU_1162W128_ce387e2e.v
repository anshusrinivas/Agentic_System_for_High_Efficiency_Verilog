`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 128
// Operations: ADD, SUB, MUL, SLTU, SRA, ROL, DIV, SEQ, MAX
// Flags: carry, zero, sign

module ALU_1162W128_ce387e2e(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [127:0] input1,
    input  wire [127:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [127:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam SLTU = 4'd3;
    localparam SRA = 4'd4;
    localparam ROL = 4'd5;
    localparam DIV = 4'd6;
    localparam SEQ = 4'd7;
    localparam MAX = 4'd8;

    // Pipeline registers
    reg [127:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 128'b0;
            input2_r <= 128'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 128'b0;
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
                SLTU: begin
                end
                SRA: begin
                    result <= $signed(input1_r) >>> shiftValue_r;
                end
                ROL: begin
                    result <= rol(input1_r, shiftValue_r);
                end
                DIV: begin
                    result <= (input2_r != 0) ? input1_r / input2_r : 128'b0;
                end
                SEQ: begin
                end
                MAX: begin
                    result <= (input1_r > input2_r) ? input1_r : input2_r;
                end
            default: result <= 128'b0;
        endcase
    end

endmodule