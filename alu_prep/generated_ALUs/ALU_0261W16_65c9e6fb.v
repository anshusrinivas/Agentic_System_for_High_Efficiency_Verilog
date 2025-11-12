`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 16
// Operations: ADD, SUB, MUL, SEQ, MAX, SLT, SNE, NOR, SLL, AND, OR, SRL
// Flags: carry, zero, overflow

module ALU_0261W16_65c9e6fb(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [15:0] input1,
    input  wire [15:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [15:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam SEQ = 4'd3;
    localparam MAX = 4'd4;
    localparam SLT = 4'd5;
    localparam SNE = 4'd6;
    localparam NOR = 4'd7;
    localparam SLL = 4'd8;
    localparam AND = 4'd9;
    localparam OR = 4'd10;
    localparam SRL = 4'd11;

    // Pipeline registers
    reg [15:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 16'b0;
            input2_r <= 16'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 16'b0;
            carryFlag <= 1'b0;
            zeroFlag <= 1'b0;
            overFlowFlag <= 1'b0;
        end else begin
            input1_r <= input1;
            input2_r <= input2;
            opcode_r <= opcode;
            shiftValue_r <= shiftValue;

            case (opcode_r)
                ADD: begin
                    {carryFlag, result} <= {1'b0, input1_r} + {1'b0, input2_r};
                    overFlowFlag <= (input1_r[15] == input2_r[15]) && (result[15] != input1_r[15]);
                end
                SUB: begin
                    {carryFlag, result} <= {1'b0, input1_r} - {1'b0, input2_r};
                    overFlowFlag <= (input1_r[15] != input2_r[15]) && (result[15] != input1_r[15]);
                end
                MUL: begin
                    result <= input1_r * input2_r;
                end
                SEQ: begin
                end
                MAX: begin
                    result <= (input1_r > input2_r) ? input1_r : input2_r;
                end
                SLT: begin
                end
                SNE: begin
                end
                NOR: begin
                    result <= ~(input1_r | input2_r);
                end
                SLL: begin
                    result <= input1_r << shiftValue_r;
                end
                AND: begin
                    result <= input1_r & input2_r;
                end
                OR: begin
                    result <= input1_r | input2_r;
                end
                SRL: begin
                    result <= input1_r >> shiftValue_r;
                end
            default: result <= 16'b0;
        endcase
    end

endmodule