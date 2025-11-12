`timescale 1ns / 1ps

// Generated ALU Module
// Style: PIPELINED
// Bit width: 8
// Operations: ADD, SUB, MUL, SLT, ROL, NOR, SRL, PASSB, SNE
// Flags: carry, zero, overflow, sign

module ALU_0406W8_546856dd(
    input  wire             clk,
    input  wire             rst,
    input  wire [3:0]  opcode,
    input  wire [7:0] input1,
    input  wire [7:0] input2,
    input  wire [4:0]       shiftValue,
    output reg  [7:0] result
    ,output reg  carryFlag
    ,output reg  zeroFlag
    ,output reg  overFlowFlag
    ,output reg  signFlag
);

    // Operation codes
    localparam ADD = 4'd0;
    localparam SUB = 4'd1;
    localparam MUL = 4'd2;
    localparam SLT = 4'd3;
    localparam ROL = 4'd4;
    localparam NOR = 4'd5;
    localparam SRL = 4'd6;
    localparam PASSB = 4'd7;
    localparam SNE = 4'd8;

    // Pipeline registers
    reg [7:0] input1_r, input2_r;
    reg [3:0] opcode_r;
    reg [4:0] shiftValue_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            input1_r <= 8'b0;
            input2_r <= 8'b0;
            opcode_r <= 4'b0;
            shiftValue_r <= 5'b0;
            result <= 8'b0;
            carryFlag <= 1'b0;
            zeroFlag <= 1'b0;
            overFlowFlag <= 1'b0;
            signFlag <= 1'b0;
        end else begin
            input1_r <= input1;
            input2_r <= input2;
            opcode_r <= opcode;
            shiftValue_r <= shiftValue;

            case (opcode_r)
                ADD: begin
                    {carryFlag, result} <= {1'b0, input1_r} + {1'b0, input2_r};
                    overFlowFlag <= (input1_r[7] == input2_r[7]) && (result[7] != input1_r[7]);
                end
                SUB: begin
                    {carryFlag, result} <= {1'b0, input1_r} - {1'b0, input2_r};
                    overFlowFlag <= (input1_r[7] != input2_r[7]) && (result[7] != input1_r[7]);
                end
                MUL: begin
                    result <= input1_r * input2_r;
                end
                SLT: begin
                end
                ROL: begin
                    result <= rol(input1_r, shiftValue_r);
                end
                NOR: begin
                    result <= ~(input1_r | input2_r);
                end
                SRL: begin
                    result <= input1_r >> shiftValue_r;
                end
                PASSB: begin
                    result <= input2_r;
                end
                SNE: begin
                end
            default: result <= 8'b0;
        endcase
    end

endmodule